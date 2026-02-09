# frozen_string_literal: true

describe Columns::ReadAgreementColumn do
  describe '#filtered_ids_for_values' do
    it 'does not filter dossiers when values are blank' do
      column = described_class.new(procedure_id: create(:procedure).id)

      seen     = create(:dossier, accuse_lecture_agreement_at: Time.current)
      not_seen = create(:dossier, accuse_lecture_agreement_at: nil)

      dossiers = Dossier.where(id: [seen.id, not_seen.id])

      expect(
        column.filtered_ids_for_values(dossiers, [])
      ).to match_array(dossiers.ids)
    end
  end
end
