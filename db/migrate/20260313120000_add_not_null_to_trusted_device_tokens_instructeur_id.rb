# frozen_string_literal: true

class AddNotNullToTrustedDeviceTokensInstructeurId < ActiveRecord::Migration[7.2]
  def change
    add_check_constraint :trusted_device_tokens, "instructeur_id IS NOT NULL", name: "trusted_device_tokens_instructeur_id_null", validate: false
  end
end
