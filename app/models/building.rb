# frozen_string_literal: true

class Building < ApplicationRecord
  belongs_to :client

  validates :street_1, :city, :state, :zipcode, presence: true
  validate :custom_fields_are_valid, if: :custom_fields_changed?

  def index_response
    attributes
      .without("custom_fields")
      .merge("client_name" => client.name)
      .merge(custom_fields)
  end

  private

  def custom_fields_are_valid
    custom_fields.each do |field, value|
      custom_field = client.custom_fields.find_by(name: field)

      unless custom_field
        errors.add(:base, "invalid custom field name: #{field}")
        next
      end

      validate_custom_field_type_value(custom_field, value)
    end
  end

  def validate_custom_field_type_value(field, value)
    case field.field_type
    when "number"
      begin
        Float(value)
      rescue ArgumentError
        errors.add(:base, "invalid value for number field type: #{value}")
      end
    when "enum"
      available = field.custom_field_options.pluck(:value)

      unless value.in?(available)
        errors.add(:base, "invalid value #{value}, must be one of #{available}")
      end
    end
  end
end
