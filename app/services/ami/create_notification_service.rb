# frozen_string_literal: true

module Ami
  class CreateNotificationService
    AMI_NOTIFICATIONS_ENABLED_STATES = [
      :en_construction,
      :en_instruction,
      :accepte,
      :refuse,
      :sans_suite,
      :repasser_en_instruction,
    ].freeze

    attr_reader :dossier, :state

    def initialize(dossier:)
      @dossier = dossier
      @state = dossier.state
    end

    def self.call(dossier:)
      new(dossier:).call
    end

    def call
      return if !eligible?

      # send notification to AMI
    end

    private

    def eligible?
      not_eligible_reason.blank?
    end

    def not_eligible_reason
      return ":ami_notifications feature flag disabled" unless dossier.procedure.feature_enabled?(:ami_notifications)

      return "state: #{state} not eligible" unless AMI_NOTIFICATIONS_ENABLED_STATES.include?(state)
    end
  end
end
