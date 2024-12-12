require 'rails_helper'

RSpec.describe Building, type: :model do
  before do
    @client = FactoryBot.create(:client)
  end

  it "ensures all provided attrs are passed" do
    building = Building.new

    expect(building.valid?).to eq(false)
    expect(building.errors.full_messages).to include("Client must exist")
    expect(building.errors.full_messages).to include("Street 1 can't be blank")
    expect(building.errors.full_messages).to include("City can't be blank")
    expect(building.errors.full_messages).to include("State can't be blank")
    expect(building.errors.full_messages).to include("Zipcode can't be blank")
  end

  it "is valid when all validations are satisfied" do
    building = @client.buildings.new(
      street_1: '123 Fake St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78727'
    )

    expect(building.valid?).to eq(true)
    expect(building.errors.full_messages).to be_empty
  end

  it "is invalid when custom field attribute doesn't exist" do
    building = @client.buildings.new(
      street_1: '123 Fake St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78727',
      custom_fields: { not_yet_created: 20 }
    )

    expect(building.valid?).to eq(false)
    expect(building.errors.full_messages).to include("invalid custom field name: not_yet_created")
  end

  it "is invalid when custom field value is invalid" do
    CustomField.create!(
      name: 'some_custom_field',
      display_name: 'A field that is custom',
      field_type: :number,
      client: @client
    )

    building = @client.buildings.new(
      street_1: '123 Fake St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78727',
      custom_fields: { some_custom_field: 'not a number' }
    )

    expect(building.valid?).to eq(false)
    expect(building.errors.full_messages).to include("invalid value for number field type: not a number")
  end

  it "#index_response returns expected format" do
    CustomField.create!(
      name: 'some_custom_field',
      display_name: 'A field that is custom',
      field_type: :number,
      client: @client
    )

    building = @client.buildings.new(
      street_1: '123 Fake St',
      city: 'Austin',
      state: 'TX',
      zipcode: '78727',
      custom_fields: { some_custom_field: '100' }
    )

    expected = {
      id: nil,
      client_id: @client.id,
      client_name: @client.name,
      street_1: building.street_1,
      street_2: nil,
      city: building.city,
      state: building.state,
      zipcode: building.zipcode,
      created_at: nil,
      updated_at: nil,
      some_custom_field: '100'
    }.stringify_keys

    expect(building.index_response).to eq(expected)
  end
end
