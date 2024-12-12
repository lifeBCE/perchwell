# frozen_string_literal: true

class CustomField < ApplicationRecord
  belongs_to :client
  has_many :custom_field_options

  accepts_nested_attributes_for :custom_field_options

  enum :field_type, { number: 0, free: 1, enum: 2 }, suffix: true

  validates :name, :display_name, presence: true
end
