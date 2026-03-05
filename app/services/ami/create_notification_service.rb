# frozen_string_literal: true

module Ami
  class CreateNotificationService
    SOURCE = ApplicationHelper::APP_HOST

    ITEM_TYPE = "dossier"

    AMI_NOTIFICATIONS_ENABLED_STATES = [
      :brouillon,
      :en_construction,
      :en_instruction,
      :accepte,
      :refuse,
      :sans_suite,
      :repasser_en_instruction,
    ].freeze

    ITEM_GENERIC_STATUS_BY_STATE = {
      brouillon: "new",
      en_construction: "wip",
      en_instruction: "wip",
      repasser_en_instruction: "wip",
      accepte: "closed",
      refuse: "closed",
      sans_suite: "closed",
    }.freeze

    attr_reader :dossier, :state

    def initialize(dossier:)
      @dossier = dossier
      @state = dossier.state.to_sym
    end

    def self.call(dossier:)
      new(dossier:).call
    end

    def call
      if !eligible?
        Rails.logger.debug { "AMI notification not eligible for dossier #{dossier.id}: #{not_eligible_reason}" }
        return
      end

      Rails.logger.debug { "AMI notification eligible for dossier #{dossier.id} (state: #{state})" }

      payload = create_notification_payload(send_date: Time.zone.now.iso8601)
      return if payload[:recipient_fc_hash].blank?

      Ami::SendNotificationJob.perform_later(payload, context)
    end

    def create_notification_payload(send_date:)
      {
        recipient_fc_hash: RecipientFcHash.call(dossier.user),
        content_title:,
        content_body:,
        item_type: ITEM_TYPE,
        item_id: dossier.id.to_s,
        item_status_label: status_label,
        item_generic_status: item_generic_status,
        item_canal: SOURCE,
        send_date:,
      }
    end

    private

    def eligible?
      not_eligible_reason.blank?
    end

    def not_eligible_reason
      return ":ami_notifications feature flag disabled" unless dossier.procedure.feature_enabled?(:ami_notifications)

      return "state: #{state} not eligible" unless AMI_NOTIFICATIONS_ENABLED_STATES.include?(state)
    end

    def content_title
      if dossier.brouillon?
        "Création de votre dossier n° #{dossier.id} pour la démarche #{dossier.procedure.libelle}"
      else
        "Mise à jour de votre dossier n° #{dossier.id} pour la démarche #{dossier.procedure.libelle}"
      end
    end

    def content_body
      if dossier.brouillon?
        "Votre dossier vient d'être créé."
      else
        "Le statut du dossier est maintenant #{status_label}."
      end
    end

    def context
      {
        procedure: dossier.procedure.id,
        dossier: dossier.id,
        state:,
      }
    end

    def status_label
      user_state = state == :en_construction ? "depose" : dossier.state
      I18n.t("activerecord.attributes.dossier/state.#{user_state}")
    end

    def item_generic_status
      ITEM_GENERIC_STATUS_BY_STATE.fetch(state.to_sym, ITEM_GENERIC_STATUS_BY_STATE.fetch(state, "wip"))
    end
  end
end
