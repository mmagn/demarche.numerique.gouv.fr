# frozen_string_literal: true

module Maintenance
  RSpec.describe T20260303BackfillCustomizedOnProcedurePresentationsTask do
    describe "#process" do
      let(:procedure) { create(:procedure, :published) }
      let(:instructeur) { create(:instructeur) }

      let!(:assign_to_default) { create(:assign_to, procedure: procedure, instructeur: instructeur) }

      let!(:assign_to_custom) { create(:assign_to, procedure: procedure, instructeur: create(:instructeur)) }

      let!(:presentation_default) do
        create(
          :procedure_presentation,
          assign_to: assign_to_default,
          displayed_columns: procedure.default_displayed_columns
        )
      end

      let!(:custom_column) { procedure.find_column(label: "Date de dépôt") }

      let!(:presentation_custom) do
        pres = create(:procedure_presentation, assign_to: assign_to_custom)
        pres.update!(displayed_columns: [custom_column])
        pres
      end

      it "marks presentations with default columns as customized: false" do
        task = described_class.new
        task.collection.each { |p| task.process(p) }
        expect(presentation_default.reload.customized).to eq(false)
      end

      it "marks presentations with custom columns as customized: true" do
        task = described_class.new
        task.collection.each { |p| task.process(p) }
        expect(presentation_custom.reload.customized).to eq(true)
      end
    end
  end
end
