# frozen_string_literal: true

class Champs::EmailChamp < Champs::TextChamp
  include EmailSanitizableConcern
  before_validation -> { sanitize_email(:value) }

  validates :value, allow_blank: true, strict_email: true, if: :should_validate_in_current_context?
end
