# frozen_string_literal: true

class ValidateNotNullTrustedDeviceTokensInstructeurId < ActiveRecord::Migration[7.2]
  def change
    validate_check_constraint :trusted_device_tokens, name: "trusted_device_tokens_instructeur_id_null"
  end
end
