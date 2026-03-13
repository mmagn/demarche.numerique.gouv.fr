# frozen_string_literal: true

require 'rails_helper'

describe Cron::TrustedDeviceTokenRenewalJob do
  let(:now) { Time.zone.local(2023, 10, 1, 12, 0, 0) }
  before { travel_to now }
  let!(:token_to_notify) do
    create(:trusted_device_token,
      activated_at: (TrustedDeviceConcern::TRUSTED_DEVICE_PERIOD - 5.days).ago,
      renewal_notified_at: nil)
  end

  subject { described_class.new.perform_now }

  it 'updates renewal_notified_at' do
    expect { subject }.to change { token_to_notify.reload.renewal_notified_at }.from(nil).to be_present
  end

  it 'creates a new trusted device token' do
    expect { subject }.to change { TrustedDeviceToken.count }.by(1)
  end

  it 'if recalled, does not resend mail' do
    expect(InstructeurMailer)
      .to receive(:trusted_device_token_renewal)
      .with(
        token_to_notify.instructeur,
        an_instance_of(String),
        now + 1.week
      )
      .and_return(double(deliver_later: true))
      .once
    described_class.new.perform_now
    described_class.new.perform_now
  end

  context 'when an instructeur has multiple expiring tokens' do
    let!(:same_instructeur_token) do
      create(:trusted_device_token,
        instructeur: token_to_notify.instructeur,
        activated_at: (TrustedDeviceConcern::TRUSTED_DEVICE_PERIOD - 3.days).ago,
        renewal_notified_at: nil)
    end

    it 'sends only one email' do
      expect(InstructeurMailer)
        .to receive(:trusted_device_token_renewal).once
        .and_return(double(deliver_later: true))
      subject
    end

    it 'marks all tokens as notified' do
      subject
      expect(token_to_notify.reload.renewal_notified_at).to be_present
      expect(same_instructeur_token.reload.renewal_notified_at).to be_present
    end

    it 'creates only one new token' do
      expect { subject }.to change { TrustedDeviceToken.count }.by(1)
    end
  end

  context 'when multiple instructeurs have expiring tokens' do
    let!(:other_instructeur_token) do
      create(:trusted_device_token,
        activated_at: (TrustedDeviceConcern::TRUSTED_DEVICE_PERIOD - 5.days).ago,
        renewal_notified_at: nil)
    end

    it 'sends one email per instructeur' do
      expect(InstructeurMailer)
        .to receive(:trusted_device_token_renewal).twice
        .and_return(double(deliver_later: true))
      subject
    end
  end
end
