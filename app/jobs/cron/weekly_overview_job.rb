# frozen_string_literal: true

class Cron::WeeklyOverviewJob < Cron::CronJob
  self.schedule_expression = "every monday at 04:05"

  def perform
    # Feature flipped to avoid mails in staging due to unprocessed dossier
    return unless Rails.application.config.ds_weekly_overview

    Instructeur
      .joins(:instructeurs_procedures)
      .where(instructeurs_procedures: { weekly_email_summary: true })
      .distinct
      .find_each do |instructeur|
        # mailer won't send anything if overview is empty
        InstructeurMailer.last_week_overview(instructeur)&.deliver_later(wait: rand(0..3.hours))
      end
  end
end
