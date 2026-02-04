# frozen_string_literal: true

class Instructeurs::OCRViewerComponent < ApplicationComponent
  attr_reader :champ

  def initialize(champ:)
    @champ = champ
  end

  def rib = champ.rib

  def render?
    champ.RIB? && champ.fetched?
  end

  def data
    if champ.RIB?
      [
        [:account_holder, sanitize(rib.account_holder&.split("\n")&.join('<br>'))],
        [:iban, rib.iban],
        [:bic, rib.bic],
        [:bank_name, rib.bank_name],
      ].map { |k, v| [RIB.human_attribute_name(k), v.presence || processing_error_message, copy: v.present?] }
    end
  end

  private

  def processing_error_message
    content_tag(:span, class: "fr-hint-text fr-text-default--warning font-weight-normal") do
      concat dsfr_icon('fr-icon-file-text-fill', :sm, :mr)
      concat t('.processing_error')
    end
  end
end
