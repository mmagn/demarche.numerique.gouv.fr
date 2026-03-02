# frozen_string_literal: true

module Ami
  class CreateNotificationService
    def initialize(dossier:)
      @dossier = dossier
    end

    def self.call(dossier:)
      new(dossier:).call
    end

    def call
    end
  end
end
