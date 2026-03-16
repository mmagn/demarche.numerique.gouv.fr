# frozen_string_literal: true

require "rails_helper"

module Maintenance
  RSpec.describe T20260316NotifyAdminsTransitoireDomainTask do
    describe "#process" do
      let(:procedure) { create(:procedure, :published) }
      let(:row) { CSV::Row.new(["url"], [url]) }

      subject { described_class.new.process(row) }

      context "with a full URL" do
        let(:url) { "https://demarches.numerique.gouv.fr/commencer/#{procedure.path}" }

        it "sends an email to all administrateurs" do
          emails = procedure.administrateurs.map { it.user.email }

          expect(BlankMailer).to receive(:send_template).with(
            to: emails,
            subject: "[#{APPLICATION_NAME}] Action requise : mise à jour de votre lien de démarche",
            title: "Mise à jour de vos liens",
            body: a_string_matching(/demarches\.numerique\.gouv\.fr/).and(a_string_matching(/#{Regexp.escape(procedure.libelle)}/))
          ).and_return(double(deliver_later: true))

          subject
        end
      end

      context "with multiple administrateurs" do
        let(:url) { "/commencer/#{procedure.path}" }
        let(:other_admin) { create(:administrateur) }

        before { procedure.administrateurs << other_admin }

        it "sends one email to all administrateurs" do
          expect(BlankMailer).to receive(:send_template).once
            .with(hash_including(to: contain_exactly(*procedure.administrateurs.map { it.user.email })))
            .and_return(double(deliver_later: true))

          subject
        end
      end
    end
  end
end
