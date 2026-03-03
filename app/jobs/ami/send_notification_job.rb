# frozen_string_literal: true

class Ami::SendNotificationJob < ApplicationJob

  def perform(payload, context = {})
    Sentry.set_tags(context)

    Rails.logger.debug { "AMI notification sending for dossier #{context[:dossier]}" }
  end
end
