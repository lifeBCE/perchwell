require 'rails_helper'

RSpec.describe CustomFieldOption, type: :model do
  before do
    @custom_field = FactoryBot.create(:custom_field)
  end

  it "ensures a provided value" do
    custom_field_option = CustomFieldOption.new

    expect(custom_field_option.valid?).to eq(false)
    expect(custom_field_option.errors.full_messages).to include("Custom field must exist")
    expect(custom_field_option.errors.full_messages).to include("Value can't be blank")
  end

  it 'is invalid when parent custom_field is the wrong field type' do
    custom_field_option = CustomFieldOption.new(custom_field: @custom_field, value: "option 1")

    expect(custom_field_option.valid?).to eq(false)
    expect(custom_field_option.errors.full_messages).to include("invalid custom field type, must be enum")
  end

  it "is valid when all validations are satisfied" do
    @custom_field.field_type = :enum
    custom_field_option = CustomFieldOption.new(custom_field: @custom_field, value: "option 1")

    expect(custom_field_option.valid?).to eq(true)
    expect(custom_field_option.errors.full_messages).to be_empty
  end
end
