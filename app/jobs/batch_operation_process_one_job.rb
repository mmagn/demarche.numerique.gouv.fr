# frozen_string_literal: true

class BatchOperationProcessOneJob < ApplicationJob
  queue_as :critical
  retry_on StandardError, attempts: 1 # default 5, for now no retryable behavior

  def perform(batch_operation, dossier)
    dossier = batch_operation.dossiers_safe_scope.find(dossier.id)
    begin
      ActiveRecord::Base.transaction do
        batch_operation.process_one(dossier)
        batch_operation.track_processed_dossier(true, dossier)

        if batch_operation.dossiers.empty?
          batch_operation.after_all_processed
        end
      end
    rescue => error
      ActiveRecord::Base.transaction do
        batch_operation.track_processed_dossier(false, dossier)

        if batch_operation.dossiers.empty?
          batch_operation.after_all_processed
        end
      end
      raise error
    end
  rescue ActiveRecord::RecordNotFound
    dossier.update_column(:batch_operation_id, nil)
  end
end
