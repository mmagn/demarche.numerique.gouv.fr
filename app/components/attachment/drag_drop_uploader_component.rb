# frozen_string_literal: true

# Renders a drag & drop zone wrapping ButtonUploaderComponent.
# Used by MultipleComponent for accessible multi-file uploads.
class Attachment::DragDropUploaderComponent < ApplicationComponent
  attr_reader :button_uploader

  def initialize(button_uploader:)
    @button_uploader = button_uploader
  end

  def render?
    @button_uploader.current_count < @button_uploader.max
  end
end
