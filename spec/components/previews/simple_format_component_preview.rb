# frozen_string_literal: true

class SimpleFormatComponentPreview < ViewComponent::Preview
  def default
    render SimpleFormatComponent.new("Bonjour,\n\nCeci est un **texte** avec du markdown.\n\n- item 1\n- item 2\n\nUn lien: https://example.com", allow_a: true)
  end

  def without_links
    render SimpleFormatComponent.new("Texte sans lien autorisé: https://example.com\n\nAvec du **gras** et une liste:\n\n1. premier\n2. deuxième", allow_a: false, allow_autolink: true)
  end
end
