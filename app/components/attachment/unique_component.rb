# frozen_string_literal: true

# Orchestrator for single file upload (has_one_attached).
# Displays ButtonUploaderComponent when empty, AttachmentRowComponent when file is present.
class Attachment::UniqueComponent < ApplicationComponent
  attr_reader :context, :attachment

  delegate :attached_file, to: :context

  def initialize(context:, attachment: nil)
    @context = context
    @attachment = attachment || attached_file.try(:attachment)
  end

  def persisted?
    !!@attachment&.persisted?
  end
end
