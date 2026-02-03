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
      max_character_length: nil
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

  describe "#formatted_hints" do
    context "when no allowed characters and no min/max" do
      it "returns empty array" do
        expect(component.formatted_hints).to eq([])
      end
    end

    context "when only letters are allowed" do
      before { allow(champ).to receive(:letters_accepted).and_return(true) }

      it "returns one hint" do
        expect(component.formatted_hints).to eq([
          "Le champ ne peut contenir que des lettres.",
        ])
      end
    end

    context "when letters and numbers are allowed" do
      before do
        allow(champ).to receive(:letters_accepted).and_return(true)
        allow(champ).to receive(:numbers_accepted).and_return(true)
      end

      it "returns a combined hint" do
        expect(component.formatted_hints).to eq([
          "Le champ peut contenir des lettres et des chiffres.",
        ])
      end
    end

    context "when letters, numbers and special characters are allowed" do
      before do
        allow(champ).to receive(:letters_accepted).and_return(true)
        allow(champ).to receive(:numbers_accepted).and_return(true)
        allow(champ).to receive(:special_characters_accepted).and_return(true)
      end

      it "returns a combined hint" do
        expect(component.formatted_hints).to eq([
          "Le champ peut contenir des lettres, des chiffres et des caractères spéciaux.",
        ])
      end
    end

    context "when only a minimum length is set" do
      before { allow(champ).to receive(:min_character_length).and_return(5) }

      it "returns a min length hint" do
        expect(component.formatted_hints).to eq([
          "Le champ doit faire au moins 5 caractères.",
        ])
      end
    end

    context "when only a maximum length is set" do
      before { allow(champ).to receive(:max_character_length).and_return(10) }

      it "returns a max length hint" do
        expect(component.formatted_hints).to eq([
          "Le champ doit faire moins de 10 caractères.",
        ])
      end
    end

    context "when both min and max lengths are set" do
      before do
        allow(champ).to receive(:min_character_length).and_return(5)
        allow(champ).to receive(:max_character_length).and_return(10)
      end

      it "returns a range hint" do
        expect(component.formatted_hints).to eq([
          "Le champ doit faire entre 5 et 10 caractères.",
        ])
      end
    end

    context "when letters are allowed and a min length is set" do
      before do
        allow(champ).to receive(:letters_accepted).and_return(true)
        allow(champ).to receive(:min_character_length).and_return(5)
      end

      it "returns two hints" do
        expect(component.formatted_hints).to eq([
          "Le champ ne peut contenir que des lettres.",
          "Le champ doit faire au moins 5 caractères.",
        ])
      end
    end

    context "when champ is not formatted" do
      before { allow(champ).to receive(:formatted?).and_return(false) }

      it "returns an empty array" do
        expect(component.formatted_hints).to eq([])
      end
    end
  end
end
