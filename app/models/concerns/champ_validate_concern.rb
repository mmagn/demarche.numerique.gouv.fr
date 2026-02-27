# frozen_string_literal: true

module ChampValidateConcern
  extend ActiveSupport::Concern

  included do
    validates_with ExternalDataChampValidator, if: :validate_external_data_response?

    private

    def should_validate_in_current_context?
      case validation_context
      when :champs_public_value
        public? && is_validation_relevant? && visible?
      when :champs_private_value
        private? && is_validation_relevant? && visible?
      when :prefill
        true
      else
        false
      end
    end

    def is_validation_relevant?
      in_dossier_stream? && in_dossier_revision? && is_same_type_as_revision? && !in_discarded_row?
    end

    def in_dossier_stream?
      dossier.stream == stream
    end

    def validate_external_data_response?
      should_validate_in_current_context? && has_async_external_data? && external_data_needed_for_validation?
    end
  end
end
