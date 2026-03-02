# frozen_string_literal: true

class JustificatifDomicile
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :beneficiary, :string
  attribute :address, :string
  attribute :postal_code, :string
  attribute :locality, :string
  attribute :country, :string
  attribute :issue_date, :date
  attribute :two_ddoc, :boolean
end
