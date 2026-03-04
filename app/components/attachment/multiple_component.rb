# frozen_string_literal: true

# Orchestrator for multiple file uploads (has_many_attached).
# Displays drag-drop uploader, hints, and list of uploaded files.
class Attachment::MultipleComponent < ApplicationComponent
  DEFAULT_MAX_ATTACHMENTS = 10

  renders_one :template

  attr_reader :attachments, :context, :max

  delegate :champ, :form_object_name, :view_as, :user_can_destroy?, :aria_labelledby, :attached_file,
           to: :context
  delegate :size, :empty?, to: :attachments, prefix: true

  def initialize(context:, max: nil)
    @context = context
    @max = max || DEFAULT_MAX_ATTACHMENTS
    @attachments = attached_file&.attachments || []
  end

  def each_attachment(&block)
    @attachments.each_with_index(&block)
  end

  def empty_component_id
    champ.present? ? "attachment-multiple-empty-#{champ.public_id}" : "attachment-multiple-empty-generic"
  end

  def auto_attach_url
    champ.present? ? helpers.auto_attach_url(champ) : '#'
  end

  def show_hint?
    champ.present?
  end

  def describedby_hint_id
    return nil if champ.nil?
    "#{champ.focusable_input_id}-pj-hint"
  end

  def hints_component
    Attachment::HintsComponent.new(
      champ:,
      attached_file:,
      show_identity_hint: champ&.titre_identite_nature?,
      html_id: describedby_hint_id
    )
  end

  def show_format_families?
    format_families_info.present?
  end

  def show_exhaustive_formats?
    return false if champ.nil? || !champ.piece_justificative?

    tdc = champ.type_de_champ
    tdc.titre_identite_nature? || tdc.RIB?
  end

  def exhaustive_formats
    return nil unless show_exhaustive_formats?

    champ.type_de_champ.allowed_extensions.join(', ')
  end

  def formats_accepted_text
    format_families_info.map { |f| "#{f[:label]} (#{f[:top_formats]}...)" }.join(', ')
  end

  def tooltip_id
    return nil if champ.nil?

    "#{champ.focusable_input_id}-formats-tooltip"
  end
end
