# frozen_string_literal: true

module Maintenance
  class T20260303BackfillCustomizedOnProcedurePresentationsTask < MaintenanceTasks::Task
    include RunnableOnDeployConcern

    def collection
      ProcedurePresentation.includes(assign_to: :procedure)
    end

    def process(presentation)
      procedure = presentation.assign_to.procedure

      presentation.update_columns(
        customized: presentation.displayed_columns.map(&:h_id).sort != procedure.default_displayed_columns.map(&:h_id).sort
      )

    # a column can be not found for various reasons (deleted tdc, changed type, etc)
    # in this case we just ignore the error and continue
    rescue ActiveRecord::RecordNotFound
    end
  end
end
