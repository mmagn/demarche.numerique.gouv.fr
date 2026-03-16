# frozen_string_literal: true

module Maintenance
  class BackfillWatermarkOnStuckBlobsTask < MaintenanceTasks::Task
    # Reprocesses blobs stuck in "Traitement en cours" due to the addalpha
    # Vips::Error that was silently swallowed before the WatermarkService::Error fix.
    #
    # Deploy AFTER the WatermarkService and ImageProcessorJob fixes.

    CUTOFF_DATE = Date.new(2026, 3, 3)
    SPREAD_DURATION = 30.minutes

    def collection
      ActiveStorage::Blob
        .where(watermarked_at: nil)
        .where(created_at: CUTOFF_DATE..)
        .joins(:attachments)
        .where(active_storage_attachments: { record_type: "Champ" })
        .joins("INNER JOIN champs ON champs.id = active_storage_attachments.record_id")
        .where(champs: { type: "Champs::TitreIdentiteChamp" })
    end

    def process(blob)
      ImageProcessorJob.set(wait: rand(0..SPREAD_DURATION)).perform_later(blob)
    end
  end
end
