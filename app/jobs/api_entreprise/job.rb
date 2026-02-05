# frozen_string_literal: true

class APIEntreprise::Job < ApplicationJob
  DEFAULT_MAX_ATTEMPTS_API_ENTREPRISE_JOBS = 5 # 5 days

  queue_as :default

  # BadGateway could mean
  # - acoss: réessayer ultérieurement
  # - bdf: erreur interne
  # so we retry every day for 5 days
  # same logic for ServiceUnavailable
  rescue_from(APIEntreprise::API::Error::ServiceUnavailable) do |exception|
    retry_or_discard(exception)
  end
  rescue_from(APIEntreprise::API::Error::BadGateway) do |exception|
    retry_or_discard(exception)
  end
  rescue_from(APIEntreprise::API::Error::InternalServerError) do |exception|
    retry_or_discard(exception)
  end

  # If by the time the job runs the Etablissement has been deleted
  # (it can happen through EtablissementUpdateJob for instance), ignore the job
  discard_on ActiveRecord::RecordNotFound

  def log_job_exception(exception)
    if etablissement.present?
      if etablissement.dossier.present?
        etablissement.dossier.log_api_entreprise_job_exception(exception)
      elsif etablissement.champ.present?
        etablissement.champ.save_additional_job_exception(exception, :unkonwn)
      end
    end
  end

  def retry_or_discard(exception)
    if executions < max_attempts
      retry_job wait: 1.day, error: exception
    else
      log_job_exception(exception)
    end
  end

  def max_attempts
    ENV.fetch("MAX_ATTEMPTS_API_ENTREPRISE_JOBS", DEFAULT_MAX_ATTEMPTS_API_ENTREPRISE_JOBS).to_i
  end

  attr_reader :etablissement

  def find_etablissement(etablissement_id)
    @etablissement = Etablissement.find(etablissement_id)
  end
end
