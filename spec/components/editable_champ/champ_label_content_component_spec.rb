# frozen_string_literal: true

RSpec.describe EditableChamp::ChampLabelContentComponent, type: :component do
  let(:form) { double }

  let(:champ) do
    instance_double(
      Champ,
      formatted?: true,
      formatted_simple?: true,
      formatted_advanced?: false,
      letters_accepted: false,
      numbers_accepted: false,
      special_characters_accepted: false,
      min_character_length: nil,
      max_character_length: nil,
      date?: false,
      datetime?: false,
      integer_number?: false,
      decimal_number?: false
    )
  end

  let(:component) do
    described_class.new(
      form: form,
      champ: champ,
      seen_at: nil,
      row_number: nil
    )
  end

  describe "#hints_for_champ" do
    context "when champ is not visible" do
      before { allow(champ).to receive(:visible?).and_return(false) }

      it "returns an empty array" do
        expect(component.hints_for_champ).to eq([])
      end
    end

    context "when champ is formatted simple" do
      before do
        allow(champ).to receive(:visible?).and_return(true)
        allow(champ).to receive(:formatted?).and_return(true)
        allow(champ).to receive(:formatted_simple?).and_return(true)
        allow(champ).to receive(:formatted_advanced?).and_return(false)
      end

      context "with no constraints" do
        it "returns no hints" do
          expect(component.hints_for_champ).to eq([])
        end
      end

      context "with allowed letters" do
        before { allow(champ).to receive(:letters_accepted).and_return(true) }

        it "returns a character hint" do
          expect(component.hints_for_champ).to eq([
            "Le champ ne peut contenir que des lettres.",
          ])
        end
      end

      context "with letters and numbers allowed" do
        before do
          allow(champ).to receive(:letters_accepted).and_return(true)
          allow(champ).to receive(:numbers_accepted).and_return(true)
        end

        it "returns a combined character hint" do
          expect(component.hints_for_champ).to eq([
            "Le champ peut contenir des lettres et des chiffres.",
          ])
        end
      end

      context "with min and max length" do
        before do
          allow(champ).to receive(:min_character_length).and_return(5)
          allow(champ).to receive(:max_character_length).and_return(10)
        end

        it "returns a range hint" do
          expect(component.hints_for_champ).to eq([
            "Le champ doit faire entre 5 et 10 caractères.",
          ])
        end
      end

      context "with letters allowed and min length" do
        before do
          allow(champ).to receive(:letters_accepted).and_return(true)
          allow(champ).to receive(:min_character_length).and_return(5)
        end

        it "returns both hints" do
          expect(component.hints_for_champ).to eq([
            "Le champ ne peut contenir que des lettres.",
            "Le champ doit faire au moins 5 caractères.",
          ])
        end
      end
    end

    context "when champ is formatted advanced" do
      before do
        allow(champ).to receive(:visible?).and_return(true)
        allow(champ).to receive(:formatted?).and_return(true)
        allow(champ).to receive(:formatted_simple?).and_return(false)
        allow(champ).to receive(:formatted_advanced?).and_return(true)
      end

      it "returns no hints" do
        expect(component.hints_for_champ).to eq([])
      end
    end

    context "when champ is not formatted" do
      before do
        allow(champ).to receive(:visible?).and_return(true)
        allow(champ).to receive(:formatted?).and_return(false)
      end

      it "returns no hints" do
        expect(component.hints_for_champ).to eq([])
      end
    end
  end
end
