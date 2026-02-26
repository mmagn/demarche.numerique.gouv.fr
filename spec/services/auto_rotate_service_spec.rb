# frozen_string_literal: true

RSpec.describe AutoRotateService, :external_deps do
  let(:image) { file_fixture("image-rotated.jpg") }
  let(:image_no_exif) { file_fixture("image-no-exif.jpg") }
  let(:image_no_rotation) { file_fixture("image-no-rotation.jpg") }
  let(:auto_rotate_service) { AutoRotateService.new }

  describe '#process' do
    it 'returns a tempfile if auto_rotate succeeds' do
      Tempfile.create(["rotated", ".jpg"]) do |output|
        result = auto_rotate_service.process(image, output)
        expect(result).not_to be_nil
        expect(result.size).to be > 0

        # Verify original needs rotation
        original = Vips::Image.new_from_file(image.to_path)
        expect(original.get("orientation")).to eq(8) # LeftBottom

        # Verify output is properly oriented (orientation stripped or set to 1)
        rotated = Vips::Image.new_from_file(output.to_path)
        orientation = begin; rotated.get("orientation"); rescue Vips::Error; 1; end
        expect(orientation).to eq(1)
      end
    end

    it 'returns nil if image does not need rotation' do
      Tempfile.create(["no_rotation", ".jpg"]) do |output|
        result = auto_rotate_service.process(image_no_rotation, output)
        expect(result).to be_nil
      end
    end

    it 'returns nil if no exif info on image' do
      Tempfile.create(["no_exif", ".jpg"]) do |output|
        result = auto_rotate_service.process(image_no_exif, output)
        expect(result).to be_nil
      end
    end
  end
end
