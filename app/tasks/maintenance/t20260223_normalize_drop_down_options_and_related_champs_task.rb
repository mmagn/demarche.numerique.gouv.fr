# frozen_string_literal: true

module Maintenance
  class T20260223NormalizeDropDownOptionsAndRelatedChampsTask < MaintenanceTasks::Task
    DROP_DOWN_TYPE_CHAMPS = [
      TypeDeChamp.type_champs.fetch(:drop_down_list),
      TypeDeChamp.type_champs.fetch(:multiple_drop_down_list),
    ].freeze

    def collection
      TypeDeChamp.where(type_champ: DROP_DOWN_TYPE_CHAMPS)
    end

    def process(type_de_champ)
      normalized_options = normalize_options(type_de_champ.drop_down_options)
      return if normalized_options == type_de_champ.drop_down_options

      normalized_values = normalized_values_by_original(type_de_champ.drop_down_options)
      # { " value " => "value" }

      update_drop_down_list_champs(type_de_champ, normalized_values) if type_de_champ.drop_down_list?
      update_multiple_drop_down_list_champs(type_de_champ, normalized_values) if type_de_champ.multiple_drop_down_list?

      type_de_champ.update!(drop_down_options: normalized_options)
    end

    private

    def normalize_options(options)
      options.filter_map { _1.to_s.squish.presence }
    end

    def normalized_values_by_original(options)
      options.index_with { _1.to_s.squish.presence }.compact
    end

    def update_drop_down_list_champs(type_de_champ, normalized_values)
      changed_values = normalized_values.filter { _1 != _2 }
      return if changed_values.empty?

      Champs::DropDownListChamp.where(stable_id: type_de_champ.stable_id, value: changed_values.keys).find_each do |champ|
        champ.update_columns(value: changed_values.fetch(champ.value))
      end
    end

    def update_multiple_drop_down_list_champs(type_de_champ, normalized_values)
      Champs::MultipleDropDownListChamp.where(stable_id: type_de_champ.stable_id).where.not(value: nil).find_each do |champ|
        old_values = parse_json_array(champ.value)
        next if old_values.nil?

        new_values = old_values
          .filter_map { normalized_values.fetch(_1, _1).presence }
          .uniq
        next if new_values == old_values

        champ.update_columns(value: new_values.presence&.to_json)
      end
    end

    def parse_json_array(value)
      parsed = JSON.parse(value)
      parsed if parsed.is_a?(Array)
    rescue JSON::ParserError
      nil
    end
  end
end
