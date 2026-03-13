# frozen_string_literal: true

class Cron::TrustedDeviceTokenRenewalJob < Cron::CronJob
  self.schedule_expression = "every day at noon"

  def perform
    Instructeur
      .joins(:trusted_device_tokens)
      .merge(TrustedDeviceToken.expiring_in_one_week)
      .distinct
      .find_each do |instructeur|
        begin
          tokens = instructeur.trusted_device_tokens.expiring_in_one_week

          ActiveRecord::Base.transaction do
            tokens.update_all(renewal_notified_at: Time.current)

            renewal_token = instructeur.create_trusted_device_token
            InstructeurMailer.trusted_device_token_renewal(
              instructeur, renewal_token,
              renewal_token.token_valid_until
            ).deliver_later
          end
        rescue StandardError => e
          Sentry.capture_exception(e)
        end
      end
  end
end
