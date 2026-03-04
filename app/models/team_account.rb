# frozen_string_literal: true

class TeamAccount
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def initialize(_params = {}) = nil
end
