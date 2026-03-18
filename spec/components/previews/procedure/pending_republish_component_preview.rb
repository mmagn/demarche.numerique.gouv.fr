# frozen_string_literal: true

class Procedure::PendingRepublishComponentPreview < ViewComponent::Preview
  def default
    procedure = Procedure.publiees.first
    render Procedure::PendingRepublishComponent.new(procedure: procedure, render_if: true)
  end
end
