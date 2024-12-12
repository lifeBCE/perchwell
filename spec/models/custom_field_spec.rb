require 'rails_helper'

RSpec.describe CustomField, type: :model do
  before do
    @client = FactoryBot.create(:client)
  end

  it "ensures a provided name" do
    custom_field = CustomField.new

    expect(custom_field.valid?).to eq(false)
    expect(custom_field.errors.full_messages).to include("Client must exist")
    expect(custom_field.errors.full_messages).to include("Name can't be blank")
    expect(custom_field.errors.full_messages).to include("Display name can't be blank")
  end

  it 'is valid when name and display_name are provides' do
    custom_field = CustomField.new(
      client: @client, name: "test_name", display_name: "Test Name"
    )

    expect(custom_field.valid?).to eq(true)
    expect(custom_field.errors.full_messages).to be_empty
  end
end
