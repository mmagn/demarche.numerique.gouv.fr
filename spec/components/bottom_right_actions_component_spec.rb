# frozen_string_literal: true

describe BottomRightActionsComponent, type: :component do
  let(:helpers_stub) do
    double(
      administrateur_signed_in?: true,
      instructeur_signed_in?: false,
      user_signed_in?: true,
      chatbot_disabled_page?: false
    )
  end

  before do
    allow(ENV).to receive(:enabled?).with("CRISP").and_return(true)
  end

  subject(:rendered_component) do
    component = described_class.new
    allow(component).to receive(:helpers).and_return(helpers_stub)
    render_inline(component)
  end

  it "renders a fixed actions wrapper with two items" do
    expect(rendered_component).to have_css(".bottom-right-actions")
    expect(rendered_component).to have_css(".bottom-right-actions__item", count: 2)
    expect(rendered_component).to have_css(".bottom-right-actions__item > button", count: 2)
  end

  it "renders a back-to-top action with the expected icon" do
    expect(rendered_component).to have_css(".bottom-right-actions__item button[title='Retour en haut de page']")
    expect(rendered_component).to have_css(".bottom-right-actions__item .fr-icon-arrow-up-circle-line")
  end

  it "renders a chat action with open-chat onclick hook" do
    expect(rendered_component).to have_css(".bottom-right-actions__item button[aria-label='Une question ?'][onclick=\"window.$crisp?.push(['do', 'chat:open'])\"]")
    expect(rendered_component).to have_css(".bottom-right-actions__item .fr-icon-question-fill")
  end
end
