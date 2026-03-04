# frozen_string_literal: true

# Displays upload hints: max file size, allowed formats, identity document requirements.
# Centralizes validation rules presentation.
class Attachment::HintsComponent < ApplicationComponent
  attr_reader :champ

  delegate :max_file_size, :allowed_extensions, to: :validation

  def initialize(champ:, attached_file: nil, show_identity_hint: false, html_id: nil)
    @champ = champ
    @attached_file = attached_file
    @show_identity_hint = show_identity_hint
    @html_id = html_id
  end

  def validation
    @validation ||= Attachment::Validation.new(attached_file: @attached_file)
  end

  def show_identity_hint?
    @champ&.titre_identite_nature?
  end

  def render?
    max_file_size.present? || allowed_extensions.present? || show_identity_hint?
  end

  def format_families_info
    @format_families_info ||= if champ.nil? || !champ.piece_justificative?
      []
    else
      tdc = champ.type_de_champ
      if tdc.titre_identite_nature? || tdc.RIB? || !tdc.pj_limit_formats? || tdc.pj_format_families.blank?
        []
      else
        tdc.pj_format_families.map(&:to_sym).filter_map do |key|
          label = I18n.t("activerecord.attributes.type_de_champ.format_families.#{key}", default: key.to_s.humanize).downcase
          top = FORMAT_FAMILY_TOP_FORMATS[key]
          all = FORMAT_FAMILY_EXAMPLES[key]
          next if top.nil?

          { key:, label:, top_formats: top, all_formats: all }
        end
      end
    end
  end
end
