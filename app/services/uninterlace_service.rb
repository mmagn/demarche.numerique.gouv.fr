# frozen_string_literal: true

class UninterlaceService
  def process(file)
    require "vips"

    uninterlace_png(file)
  end

  private

  def uninterlace_png(uploaded_file)
    if interlaced?(uploaded_file.to_path)
      image = Vips::Image.new_from_file(uploaded_file.to_path)
      image.write_to_file(uploaded_file.to_path, interlace: false)
      uploaded_file.reopen(uploaded_file.to_path, 'rb')
    end
    uploaded_file
  end

  def interlaced?(png_path)
    return false if png_path.blank?

    image = Vips::Image.new_from_file(png_path)

    return false if !image.get_fields.include?("interlaced")

    image.get("interlaced") != 0
  end
end
