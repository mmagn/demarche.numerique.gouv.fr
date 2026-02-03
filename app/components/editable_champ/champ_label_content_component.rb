# frozen_string_literal: true

class EditableChamp::ChampLabelContentComponent < ApplicationComponent
  include ApplicationHelper
  include Dsfr::InputErrorable

  attr_reader :attribute

  def initialize(form:, champ:, seen_at: nil, row_number: nil)
    @form, @champ, @seen_at, @row_number = form, champ, seen_at, row_number
    @attribute = :value
  end

  def highlight_if_unseen_class
    if highlight?
      'highlighted'
    end
  end

  def highlight?
    @champ.updated_at.present? && @seen_at&.<(@champ.updated_at)
  end

  def rebased?
    return false if @champ.rebased_at.blank?
    return false if @champ.rebased_at <= (@seen_at || @champ.updated_at)
    return false if !current_user.owns_or_invite?(@champ.dossier)
    return false if @champ.dossier.for_procedure_preview?

    true
  end

  def formatted_hints
    generate_formatted_hints
  end

  private

  def generate_formatted_hints
    return [] if !@champ.formatted?

    if @champ.formatted_simple?
      hints = []

      letters_accepted = @champ.letters_accepted
      numbers_accepted = @champ.numbers_accepted
      special_characters_accepted = @champ.special_characters_accepted

      allowed_parts = []
      allowed_parts << :letters if letters_accepted
      allowed_parts << :numbers if numbers_accepted
      allowed_parts << :special_characters if special_characters_accepted

      if allowed_parts.any?
        allowed_key = allowed_parts.join('_and_')
        hints << I18n.t("activerecord.attributes.champs/formatted_champ.hints.allowed.#{allowed_key}")
      end

      min = @champ.min_character_length
      max = @champ.max_character_length

      if min.present? && max.present?
        hints << I18n.t(
          'activerecord.attributes.champs/formatted_champ.hints.range.both',
          min: min,
          max: max
        )
      elsif min.present?
        hints << I18n.t(
          'activerecord.attributes.champs/formatted_champ.hints.range.min_only',
          min: min
        )
      elsif max.present?
        hints << I18n.t(
          'activerecord.attributes.champs/formatted_champ.hints.range.max_only',
          max: max
        )
      end

      hints

    elsif @champ.formatted_advanced?
      []
    else
      []
    end
  end
end
