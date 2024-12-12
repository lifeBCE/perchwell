# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :buildings
  has_many :custom_fields

  accepts_nested_attributes_for :custom_fields

  validates :name, presence: true
end
