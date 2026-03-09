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

    attr_reader :dossier, :state, :trigger

    def initialize(dossier:, trigger: :dossier_state_change)
      @dossier = dossier
      @state = dossier.state.to_sym
      @trigger = trigger.to_sym
    end

    def self.call(dossier:, trigger: :dossier_state_change)
      new(dossier:, trigger:).call
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
        item_status_label:,
        item_generic_status:,
        item_external_url:,
        item_canal: ApplicationHelper::APP_HOST,
        send_date:,
      }
    end

    private

    def item_external_url
      if messagerie_message?
        Rails.application.routes.url_helpers.messagerie_dossier_url(dossier)
      else
        Rails.application.routes.url_helpers.dossier_url(dossier)
      end
    end

    def eligible?
      not_eligible_reason.blank?
    end

    def not_eligible_reason
      return ":ami_notifications feature flag disabled" unless dossier.procedure.feature_enabled?(:ami_notifications)

      return "state: #{state} not eligible" unless AMI_NOTIFICATIONS_ENABLED_STATES.include?(state)
    end

    def content_title
      if messagerie_message?
        "Nouveau message pour votre dossier n°#{dossier.id} sur la démarche #{dossier.procedure.libelle}"
      elsif dossier.brouillon?
        "Création de votre dossier n°#{dossier.id} pour la démarche #{dossier.procedure.libelle}"
      else
        "Mise à jour de votre dossier n°#{dossier.id} pour la démarche #{dossier.procedure.libelle}"
      end
    end

    def content_body
      if messagerie_message?
        "Vous avez reçu un nouveau message dans la messagerie."
      elsif dossier.brouillon?
        "Votre dossier vient d'être créé."
      else
        "Le statut du dossier est maintenant #{item_status_label}."
      end
    end

    def context
      {
        procedure: dossier.procedure.id,
        dossier: dossier.id,
        state:,
      }
    end

    def item_status_label
      user_state = state == :en_construction ? "depose" : dossier.state
      I18n.t("activerecord.attributes.dossier/state.#{user_state}")
    end

    def item_generic_status
      ITEM_GENERIC_STATUS_BY_STATE.fetch(state.to_sym, ITEM_GENERIC_STATUS_BY_STATE.fetch(state, "wip"))
    end

    def messagerie_message?
      trigger == :messagerie_message
    end
  end
end
