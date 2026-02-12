# frozen_string_literal: true

class ProcedureOverview
  attr_accessor :procedure,
    :created_dossiers_count,
    :dossiers_en_instruction_count,
    :old_dossiers_en_instruction,
    :dossiers_en_construction_count,
    :old_dossiers_en_construction

  def initialize(procedure, dossiers)
    @start_date = 1.week.ago.beginning_of_week
    @procedure = procedure

    dossiers_en_instruction = dossiers.state_en_instruction
    dossiers_en_construction = dossiers.state_en_construction

    @dossiers_en_instruction_count = dossiers_en_instruction.count
    @dossiers_en_construction_count = dossiers_en_construction.count

    @old_dossiers_en_instruction =
      dossiers_en_instruction.where(en_instruction_at: ...1.week.ago).select(:id).to_a

    @old_dossiers_en_construction =
      dossiers_en_construction.where(depose_at: ...1.week.ago).select(:id).to_a

    @created_dossiers_count =
      dossiers.where(created_at: @start_date..).count
  end

  def had_some_activities?
    [
      @dossiers_en_instruction_count,
      @dossiers_en_construction_count,
      @created_dossiers_count,
    ].reduce(:+) > 0
  end

  def dossiers_en_construction_description
    case @dossiers_en_construction_count
    when 0
      nil
    when 1
      'dossier en construction'
    else
      'dossiers en construction'
    end
  end

  def dossiers_en_instruction_description
    case @dossiers_en_instruction_count
    when 0
      nil
    when 1
      "dossier est en cours d’instruction"
    else
      "dossiers sont en cours d’instruction"
    end
  end

  def created_dossier_description
    formated_date = I18n.l(@start_date.to_date, format: :long)

    case @created_dossiers_count
    when 0
      nil
    when 1
      "nouveau dossier a été déposé depuis le #{formated_date}"
    else
      "nouveaux dossiers ont été déposés depuis le #{formated_date}"
    end
  end
end
