# frozen_string_literal: true

class Dossiers::UserFilterComponent < ApplicationComponent
  include DossierHelper

  def initialize(statut:, filter:, procedure_id:)
    @statut = statut
    @filter = filter
    @procedure_id = procedure_id
  end

  attr_reader :statut, :filter, :procedure_id

  def render?
    ['en-cours', 'traites'].include?(@statut)
  end

  def states_collection(statut)
    case statut
    when 'en-cours'
      (Dossier.states.values - Dossier::TERMINE) << Dossier::A_CORRIGER
    when 'traites'
      Dossier::TERMINE
    end
      .map { |state| [user_translation(state), state] }
  end

  private

  def user_translation(state)
    # hack to use depose term for users
    key = (state == 'en_construction') ? 'depose' : state
    t("activerecord.attributes.dossier/state.#{key}")
  end
end
