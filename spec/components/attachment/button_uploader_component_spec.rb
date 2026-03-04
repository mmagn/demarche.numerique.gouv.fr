# frozen_string_literal: true

RSpec.describe Attachment::ButtonUploaderComponent, type: :component do
  include ChampAriaLabelledbyHelper

  let(:procedure) { create(:procedure, :published, types_de_champ_public:) }
  let(:types_de_champ_public) { [{ type: :titre_identite }] }
  let(:dossier) { create(:dossier, procedure:) }
  let(:champ) { dossier.champs.first }
  let(:attached_file) { champ.piece_justificative_file }
  let(:context_kwargs) { {} }
  let(:kwargs) { {} }

  let(:context) do
    Attachment::Context.new(champ:, **context_kwargs)
  end

  let(:component) do
    described_class.new(context:, **kwargs)
  end

  subject { render_inline(component).to_html }

  context 'piece justificative nature titre_identite' do
    let(:types_de_champ_public) { [{ type: :piece_justificative, nature: 'TITRE_IDENTITE' }] }

    it 'sets accept to jpg/jpeg/png only' do
      expect(subject).to have_selector("input[accept*='image/jpeg']")
      expect(subject).to have_selector("input[accept*='image/png']")
      expect(subject).not_to have_selector("input[accept*='application/pdf']")
    end

    it 'sets max size to 20MB in data attribute' do
      subject
      expect(page.find('input')['data-max-file-size'].to_i).to eq(20.megabytes)
    end
  end

  context 'piece justificative limited to document_texte' do
    let(:types_de_champ_public) { [{ type: :piece_justificative, pj_limit_formats: '1', pj_format_families: ['document_texte'] }] }

    it 'accept includes .pdf but not .zip' do
      expect(subject).to have_selector("input[accept*='application/pdf']")
      expect(subject).not_to have_selector("input[accept*='application/zip']")
    end
  end

  context 'piece justificative standard' do
    let(:types_de_champ_public) { [{ type: :piece_justificative }] }

    it 'has a non empty accept' do
      subject
      expect(page.find('input')['accept']).to be_present
    end
  end

  it 'renders a file input' do
    expect(subject).to have_selector('input[type=file]:not([disabled])')
  end

  describe 'aria describedby' do
    let(:parent_hint_id) { "#{champ.focusable_input_id}-pj-hint" }
    let(:context_kwargs) { { parent_hint_id: } }
    let(:describedby_attribute) { page.find('input')['aria-describedby'].split }

    it 'targets describedby_id and parent_hint_id' do
      subject
      expect(describedby_attribute).to eq([champ.describedby_id, parent_hint_id])
    end

    context 'when there is an error' do
      before { champ.errors.add(:value, 'is invalid') }

      it 'targets error_id' do
        subject
        expect(describedby_attribute).to eq([champ.describedby_id, parent_hint_id, champ.error_id(:value)])
      end
    end

    context 'without parent_hint_id' do
      let(:context_kwargs) { {} }

      it 'only targets describedby_id' do
        subject
        expect(describedby_attribute).to eq([champ.describedby_id])
      end
    end
  end

  describe 'aria-labelledby' do
    let(:context_kwargs) { { aria_labelledby: input_label_id(champ) } }

    it 'targets input_id' do
      expect(subject).to have_selector("input[aria-labelledby='#{input_label_id(champ)}']")
    end
  end

  describe 'field name inference' do
    it 'by default generates input name from attached file object' do
      expect(subject).to have_selector("input[name='champs_titre_identite_champ[piece_justificative_file]']")
    end

    context 'when a form object_name is provided' do
      let(:context_kwargs) { { form_object_name: 'my_form' } }

      it 'generates input name from form object name' do
        expect(subject).to have_selector("input[name='my_form[piece_justificative_file]']")
      end
    end
  end

  context 'when max is reached' do
    let(:kwargs) { { current_count: 1, max: 1 } }

    it 'renders a disabled input' do
      expect(subject).to have_selector('input[type=file][disabled]')
    end
  end
end
