# frozen_string_literal: true

# Renders a file input button (no drag & drop zone).
# Builds file_field options (accept, max_file_size, aria attributes).
# Uses Attachment::Context for shared configuration.
class Attachment::ButtonUploaderComponent < ApplicationComponent
  attr_reader :context, :as_multiple, :max, :current_count
  alias as_multiple? as_multiple

  delegate :champ, :direct_upload, :aria_labelledby,
           :parent_hint_id, :form_object_name, :attached_file, to: :context

  def initialize(context:, as_multiple: false, current_count: 0, max: nil)
    @context = context
    @as_multiple = as_multiple
    @current_count = current_count
    @max = max
  end

  def attachment_input_class
    "attachment-input-#{attachment_id}"
  end

  def attachment_id
    @attachment_id ||= SecureRandom.uuid
  end

  def validation
    @validation ||= Attachment::Validation.new(attached_file:)
  end

  def file_field_options
    options = {
      class: class_names("fr-upload attachment-input": true, "#{attachment_input_class}": true),
      direct_upload:,
      id: input_id,
      data: {
        auto_attach_url:,
        turbo_force: :server,
        'enable-submit-if-uploaded-target': 'input',
      }.merge(validation.max_file_size.present? ? { max_file_size: validation.max_file_size } : {})
        .merge(as_multiple? && @max ? { max: @max } : {}),
    }

    describedby = []
    describedby << champ.describedby_id if champ&.description.present?
    describedby << parent_hint_id if parent_hint_id.present?
    describedby << champ.error_id(:value) if champ&.errors&.has_key?(:value)

    options[:aria] = { describedby: describedby.join(' '), labelledby: aria_labelledby }

    accept = validation.accept_attribute
    options.merge!(accept.present? ? { accept: } : {})
    options[:multiple] = true if as_multiple?
    options[:disabled] = true if @max && @current_count >= @max

    options
  end

  def auto_attach_url
    return context.auto_attach_url if context.auto_attach_url.present?
    return helpers.auto_attach_url(champ) if champ.present?

    nil
  end

  def field_name_or_default
    field_name = form_object_name || ActiveModel::Naming.param_key(attached_file.record)
    "#{field_name}[#{attribute_name}]"
  end

  def attribute_name
    attached_file.name
  end

  def input_id
    if champ.present?
      champ.focusable_input_id
    else
      dom_id(attached_file.record, attribute_name)
    end
  end
end
