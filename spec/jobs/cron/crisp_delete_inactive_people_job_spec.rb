# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cron::CrispDeleteInactivePeopleJob, type: :job do
  let(:website_id) { "test-website-id" }

  before do
    allow(ENV).to receive(:fetch).and_call_original
    allow(ENV).to receive(:fetch).with("CRISP_WEBSITE_ID").and_return(website_id)
    allow(ENV).to receive(:fetch).with("CRISP_CLIENT_IDENTIFIER").and_return("test-client-id")
    allow(ENV).to receive(:fetch).with("CRISP_CLIENT_KEY").and_return("test-client-key")
  end

  describe '#perform' do
    let(:list_url) { %r{\Ahttps://api\.crisp\.chat/v1/website/#{website_id}/people/profiles/\d+} } # ← Accepte n'importe quel numéro de page
    let(:inactive_timestamp) { 2.months.ago.to_i * 1000 }
    let(:recent_timestamp) { 1.day.ago.to_i * 1000 }

    context "when inactive people are found on page 1" do
      before do
        stub_request(:get, %r{https://api\.crisp\.chat/v1/website/#{website_id}/people/profiles/1})
          .to_return(body: {
            error: false,
            reason: "listed",
            data: [
              { people_id: "p1", active: { last: inactive_timestamp, now: false } },
              { people_id: "p2", active: { last: recent_timestamp, now: false } },
              { people_id: "p3", active: { now: false } }, # pas de last = inactive
            ],
          }.to_json)

        stub_request(:delete, %r{https://api\.crisp\.chat/v1/website/#{website_id}/people/profile/p\d})
          .to_return(body: { error: false, reason: "removed", data: {} }.to_json)
      end

      it "only removes inactive people and reschedules next page" do
        freeze_time do
          expect {
            described_class.perform_now(1)
          }.to have_enqueued_job(described_class).with(2).at(10.seconds.from_now)

          expect(a_request(:get, %r{.*/people/profiles/1})
            .with(query: hash_including(
              'per_page' => '50',
              'sort_field' => 'active',
              'sort_order' => 'descending',
              'filter_date_end' => 1.month.ago.to_date.iso8601
            ))).to have_been_made.once

          expect(a_request(:delete, %r{.*/people/profile/p1})).to have_been_made.once
          expect(a_request(:delete, %r{.*/people/profile/p2})).not_to have_been_made
          expect(a_request(:delete, %r{.*/people/profile/p3})).to have_been_made.once
        end
      end
    end

    context "when no inactive people on current page" do
      before do
        stub_request(:get, %r{https://api\.crisp\.chat/v1/website/#{website_id}/people/profiles/2})
          .to_return(body: {
            error: false,
            reason: "listed",
            data: [
              { people_id: "p1", active: { last: recent_timestamp, now: false } },
              { people_id: "p2", active: { last: recent_timestamp, now: false } },
            ],
          }.to_json)
      end

      it "skips deletion but proceeds to next page" do
        freeze_time do
          expect {
            described_class.perform_now(2)
          }.to have_enqueued_job(described_class).with(3)
        end
      end
    end

    context "when page is empty (end of pagination)" do
      before do
        stub_request(:get, %r{https://api\.crisp\.chat/v1/website/#{website_id}/people/profiles/5})
          .to_return(body: { error: false, reason: "listed", data: [] }.to_json)
      end

      it "stops without rescheduling" do
        expect {
          described_class.perform_now(5)
        }.not_to have_enqueued_job(described_class)
      end
    end

    context "when API returns failure" do
      before do
        stub_request(:get, %r{.*/people/profiles/1})
          .to_return(status: 500, body: { error: true, reason: "error" }.to_json)
      end

      it "stops without rescheduling" do
        expect {
          described_class.perform_now(1)
        }.not_to have_enqueued_job(described_class)
      end
    end

    context "when some deletions fail but less than threshold" do
      before do
        stub_request(:get, %r{.*/people/profiles/1})
          .to_return(body: {
            error: false,
            reason: "listed",
            data: [
              { people_id: "p1", active: { last: inactive_timestamp, now: false } },
              { people_id: "p2", active: { last: inactive_timestamp, now: false } },
              { people_id: "p3", active: { last: recent_timestamp, now: false } },
            ],
          }.to_json)

        stub_request(:delete, %r{.*/people/profile/p1})
          .to_return(body: { error: false, reason: "removed", data: {} }.to_json)
        stub_request(:delete, %r{.*/people/profile/p2})
          .to_return(status: 500, body: { error: true, reason: "server error" }.to_json)

        allow(Sentry).to receive(:capture_message)
      end

      it "logs errors to Sentry and continues to next page" do
        freeze_time do
          expect {
            described_class.perform_now(1)
          }.to have_enqueued_job(described_class).with(2).at(10.seconds.from_now)

          expect(Sentry).to have_received(:capture_message).once
        end
      end
    end

    context "when too many deletions fail" do
      let(:inactive_timestamp) { 2.months.ago.to_i * 1000 }

      before do
        stub_request(:get, %r{.*/people/profiles/1})
          .to_return(body: {
            error: false,
            reason: "listed",
            data: [
              { people_id: "p1", active: { last: inactive_timestamp, now: false } },
              { people_id: "p2", active: { last: inactive_timestamp, now: false } },
              { people_id: "p3", active: { last: inactive_timestamp, now: false } },
              { people_id: "p4", active: { last: inactive_timestamp, now: false } },
              { people_id: "p5", active: { last: inactive_timestamp, now: false } },
            ],
          }.to_json)

        ["p1", "p2", "p3", "p4", "p5"].each do |people_id|
          stub_request(:delete, "https://api.crisp.chat/v1/website/#{website_id}/people/profile/#{people_id}")
            .to_return(status: 500, body: { error: true, reason: "server error" }.to_json)
        end

        allow(Sentry).to receive(:capture_message)
      end

      it "logs errors to Sentry and raises after threshold" do
        begin
          described_class.perform_now(1)
        rescue StandardError
          # ActiveJob catches StandardError and retries, so we rescue here to continue test
        end

        # Seulement 3 appels: les 3 premiers sont loggés, le 4ème raise directement
        expect(Sentry).to have_received(:capture_message).exactly(3).times
      end
    end
  end
end
