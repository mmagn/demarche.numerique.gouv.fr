# frozen_string_literal: true

module Dsfr
  class ProgressBarComponent < ApplicationComponent
    attr_reader :id, :simulated

    def initialize(simulated: false, id: nil)
      @simulated = simulated
      @id = id || SecureRandom.uuid
    end

    def container_classes
      class_names('direct-upload', 'fr-fieldset', 'fr-pb-3w', 'direct-upload--simulated': simulated)
    end
  end
end
