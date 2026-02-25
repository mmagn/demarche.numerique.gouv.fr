# frozen_string_literal: true

class AutoRotateService
  def process(file, output)
    require "vips"

    image = Vips::Image.new_from_file(file.to_path)
    orientation = image.get("orientation")

    return nil if orientation == 1 # TopLeft = no rotation needed

    rotated = Vips::Image.new_from_file(file.to_path, autorotate: true)
    rotated.write_to_file(output.to_path)
    output
  rescue Vips::Error
    nil
  end
end
