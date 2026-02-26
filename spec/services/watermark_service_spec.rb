# frozen_string_literal: true

RSpec.describe WatermarkService, :external_deps do
  let(:image) { file_fixture("logo_test_procedure.png") }
  let(:watermark_service) { WatermarkService.new }

  describe '#process' do
    it 'returns a tempfile if watermarking succeeds' do
      Tempfile.create(["watermarked", ".png"]) do |output|
        watermark_service.process(image, output)
        # output size should always be a little greater than input size
        expect(output.size).to be_between(image.size, image.size * 1.5)
      end
    end

    it 'raises Vips::Error for unsupported files' do
      Tempfile.create(["invalid", ".txt"]) do |invalid_file|
        invalid_file.write("not an image")
        invalid_file.flush

        Tempfile.create(["output", ".png"]) do |output|
          expect { watermark_service.process(invalid_file, output) }.to raise_error(Vips::Error)
        end
      end
    end
  end
end
