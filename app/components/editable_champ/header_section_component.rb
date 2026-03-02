# frozen_string_literal: true

class EditableChamp::HeaderSectionComponent < ApplicationComponent
  def initialize(form: nil, champ:, seen_at: nil, html_class: {})
    @champ = champ
    @html_class = html_class
  end

  def level
    @champ.level + 2 # The first title level should be a <h3>
  end

  def collapsible?
    @champ.level == 1
  end

  def libelle
    @champ.libelle
  end

  def header_section_classnames
    class_names(
      {
        "section-#{level}": true,
        # Accessibility:
        # A hidden <h2> ("Formulaire") is injected above the form to fix
        # the document heading structure. We decrement the DSFR visual
        # heading level so the UI appearance remains unchanged.
        "fr-h#{level - 1}": true,
        'header-section': @champ.dossier.auto_numbering_section_headers_for?(@champ.type_de_champ),
        'hidden': !@champ.visible?,
      }.merge(@html_class)
    )
  end

  def tag_for_depth
    if level <= 6
      "h#{level}"
    else
      "p"
    end
  end
end
