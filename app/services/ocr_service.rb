# frozen_string_literal: true

class OCRService
  include Dry::Monads[:result]
  extend Dry::Monads[:result]

  def self.analyze(blob)
    blob_url = blob.url
    analyze_rib(blob_url)
  end

  private

  def self.analyze_rib(blob_url)
    return not_configured("OCR_SERVICE_URL") if ocr_url.nil?

    json = { "url": blob_url, "hint": { "type": "rib" } }
    headers = { 'X-Remote-File': blob_url } # needed for logging

    API::Client.new.call(url: ocr_url, method: :post, headers:, json:, timeout: 31)
      .fmap { |ok| { value_json: ok.body } } # store directly in value_json without transformation
      .or { to_retryable_failure(it) }
  end

  def self.ocr_url = ENV.fetch("OCR_SERVICE_URL", nil)

  def self.not_configured(message)
    Failure(retryable: false, reason: StandardError.new("#{message} not configured"))
  end

  def self.to_retryable_failure(data)
    case data
    in code:, reason:
      Failure(retryable: false, reason:, code:)
    else
      Failure(retryable: false, reason: StandardError.new('Unknown error'))
    end
  end
end
