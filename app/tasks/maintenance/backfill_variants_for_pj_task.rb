# frozen_string_literal: true

module Maintenance
  class BackfillVariantsForPjTask < MaintenanceTasks::Task
    # Enqueues jobs to generate thumbnails for files (images and/or PDFs)
    # for dossiers submitted between two dates.
    #
    # Unlike CreateVariantsForPjOfLatestDossiersTask which processes synchronously,
    # this task enqueues jobs for each dossier.
    #
    # This task should be performed cautiously, using a limited number of files,
    # preferably at night and on weekends.

    attribute :start_text, :string
    validates :start_text, presence: true

    attribute :end_text, :string
    validates :end_text, presence: true

    attribute :file_type, :string
    validates :file_type, inclusion: { in: ['image', 'pdf', ''] }

    def collection
      start_date = DateTime.parse(start_text)
      end_date = DateTime.parse(end_text)

      Dossier
        .state_en_construction_ou_instruction
        .where(depose_at: start_date..end_date)
    end

    def process(dossier)
      BackfillVariantsForDossierJob.perform_later(dossier.id, file_type)
    end
  end
end
