# frozen_string_literal: true

require "rails_helper"

module Maintenance
  RSpec.describe T20260223NormalizeDropDownOptionsAndRelatedChampsTask do
    describe "#process" do
      subject(:process) { described_class.new.process(type_de_champ) }

      context "with drop down list champs" do
        let(:procedure) do
          create(
            :procedure,
            types_de_champ_public: [
              {
                type: :drop_down_list,
                drop_down_options: ["  Foo   Bar  ", "Baz"],
              },
            ]
          )
        end
        let(:type_de_champ) { procedure.active_revision.types_de_champ_public.first }
        let(:dossier) { create(:dossier, :with_populated_champs, procedure:) }
        let(:champ) { dossier.champs.first }

        before do
          type_de_champ.update_column(:options, type_de_champ.options.merge(drop_down_options: ["  Foo   Bar  ", "Baz"]))
          champ.update_columns(value: "  Foo   Bar  ")
        end

        it "normalizes options and related champ values" do
          expect { process }
            .to change { type_de_champ.reload.drop_down_options }
            .from(["  Foo   Bar  ", "Baz"])
            .to(["Foo Bar", "Baz"])
            .and change { champ.reload.value }
            .from("  Foo   Bar  ")
            .to("Foo Bar")
        end
      end

      context "with multiple drop down list champs" do
        let(:procedure) do
          create(
            :procedure,
            types_de_champ_public: [
              {
                type: :multiple_drop_down_list,
                drop_down_options: ["  Alpha   Beta  ", "Gamma", "Delta"],
              },
            ]
          )
        end
        let(:type_de_champ) { procedure.active_revision.types_de_champ_public.first }
        let(:dossier) { create(:dossier, :with_populated_champs, procedure:) }
        let(:champ) { dossier.champs.first }

        before do
          type_de_champ.update_column(:options, type_de_champ.options.merge(drop_down_options: ["  Alpha   Beta  ", "Alpha Beta", "Gamma"]))
          champ.update_columns(value: ["  Alpha   Beta  ", "Alpha Beta", "Gamma"].to_json)
        end

        it "normalizes options and deduplicates normalized selected values" do
          expect { process }
            .to change { type_de_champ.reload.drop_down_options }
            .from(["  Alpha   Beta  ", "Alpha Beta", "Gamma"])
            .to(["Alpha Beta", "Alpha Beta", "Gamma"])
            .and change { champ.reload.value }
            .from(["  Alpha   Beta  ", "Alpha Beta", "Gamma"].to_json)
            .to(["Alpha Beta", "Gamma"].to_json)
        end
      end

      context "when options are already normalized" do
        let(:procedure) do
          create(
            :procedure,
            types_de_champ_public: [
              {
                type: :drop_down_list,
                drop_down_options: ["Foo Bar", "Baz"],
              },
            ]
          )
        end
        let(:type_de_champ) { procedure.active_revision.types_de_champ_public.first }
        let(:dossier) { create(:dossier, :with_populated_champs, procedure:) }
        let!(:champ) { dossier.champs.first }

        it "does nothing" do
          expect { process }.not_to change { [type_de_champ.reload.drop_down_options, champ.reload.value] }
        end
      end
    end
  end
end
