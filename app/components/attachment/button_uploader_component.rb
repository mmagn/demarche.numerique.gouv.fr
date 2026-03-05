# frozen_string_literal: true

# DEPRECATED: Use Attachment::FileInputComponent instead
# This alias exists for backwards compatibility during migration
class Attachment::ButtonUploaderComponent < Attachment::FileInputComponent
  def initialize(context:, as_multiple: false, max: nil, current_count: 0)
    # Ignore as_multiple parameter (deduced automatically)
    super(context:, max:, current_count:)
  end
end
