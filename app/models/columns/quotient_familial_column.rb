# frozen_string_literal: true

class Columns::QuotientFamilialColumn < Columns::JSONPathColumn
  QUOTIENT_FAMILIAL_COLUMNS = [
    ['[Allocataire 1] Nom de naissance', '$.api_part.allocataires[0].nom_naissance'],
    ['[Allocataire 1] Prénoms', '$.api_part.allocataires[0].prenoms'],
    ['[Allocataire 2] Nom de naissance', '$.api_part.allocataires[1].nom_naissance'],
    ['[Allocataire 2] Prénoms', '$.api_part.allocataires[1].prenoms'],
    ['Valeur du QF', '$.api_part.quotient_familial.valeur'],
    ['Période du QF', '$.api_part.quotient_familial.periode_effective'],
  ]

  private

  def typed_value(champ)
    return super if champ.fc_data_correct?
  end
end
