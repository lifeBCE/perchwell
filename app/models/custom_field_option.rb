# frozen_string_literal: true

class CustomFieldOption < ApplicationRecord
  belongs_to :custom_field

  validates :value, presence: true
  validate :custom_field_is_enum

  private

  def custom_field_is_enum
    return unless custom_field

    unless custom_field.enum_field_type?
      errors.add(:base, "invalid custom field type, must be enum")
    end
  end
end
