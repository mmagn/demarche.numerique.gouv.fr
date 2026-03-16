# frozen_string_literal: true

class BottomRightActionsComponent < ApplicationComponent
  def render?
    render_back_to_top_button? || render_need_help_button?
  end

  def render_back_to_top_button?
    helpers.administrateur_signed_in? || helpers.instructeur_signed_in?
  end

  def render_need_help_button?
    ENV.enabled?("CRISP") && !helpers.chatbot_disabled_page? && helpers.user_signed_in?
  end
end
