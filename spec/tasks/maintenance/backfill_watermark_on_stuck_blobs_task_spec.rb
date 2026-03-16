# frozen_string_literal: true

RSpec.describe Maintenance::BackfillWatermarkOnStuckBlobsTask do
  describe '#collection' do
    let(:procedure) { create(:procedure, types_de_champ_public: [{ type: :titre_identite }]) }
    let(:dossier) { create(:dossier, :en_construction, :with_populated_champs, procedure:) }
    let(:titre_identite_champ) { dossier.project_champs_public.first }
    let(:blob) { titre_identite_champ.piece_justificative_file.blobs.first }

    subject(:task) { described_class.new }

    context 'when blob has no watermark and was created after cutoff date' do
      before do
        blob.update_columns(watermarked_at: nil, created_at: Date.new(2026, 3, 4))
      end

      it 'includes the blob' do
        expect(task.collection).to include(blob)
      end
    end

    context 'when blob is already watermarked' do
      before do
        blob.update_columns(watermarked_at: Time.current, created_at: Date.new(2026, 3, 4))
      end

      it 'does not include the blob' do
        expect(task.collection).not_to include(blob)
      end
    end

    context 'when blob was created before cutoff date' do
      before do
        blob.update_columns(watermarked_at: nil, created_at: Date.new(2026, 3, 1))
      end

      it 'does not include the blob' do
        expect(task.collection).not_to include(blob)
      end
    end
  end

  describe '#process' do
    let(:procedure) { create(:procedure, types_de_champ_public: [{ type: :titre_identite }]) }
    let(:dossier) { create(:dossier, :en_construction, :with_populated_champs, procedure:) }
    let(:blob) { dossier.project_champs_public.first.piece_justificative_file.blobs.first }

    subject(:task) { described_class.new }

    it 'enqueues an ImageProcessorJob' do
      expect {
        task.process(blob)
      }.to have_enqueued_job(ImageProcessorJob).with(blob)
    end
  end
end
