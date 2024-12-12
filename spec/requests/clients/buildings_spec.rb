require 'rails_helper'

RSpec.describe "Buildings", type: :request do
  describe "GET /index" do
    before do
      @building = FactoryBot.create(:building)
      @client = @building.client
    end

    it 'returns a successfull response' do
      get client_buildings_path(@client.id, format: :json)
      parsed_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(parsed_response['status']).to eq('success')
    end

    it 'returns expected data in response' do
      get client_buildings_path(@client.id, format: :json)
      parsed_response = JSON.parse(response.body)
      building_attrs = parsed_response['buildings'].first

      expect(building_attrs['street_1']).to eq(@building.street_1)
      expect(building_attrs['street_2']).to eq(@building.street_2)
      expect(building_attrs['city']).to eq(@building.city)
      expect(building_attrs['state']).to eq(@building.state)
      expect(building_attrs['zipcode']).to eq(@building.zipcode)
    end
  end

  describe 'POST /create' do
    before do
      @client = FactoryBot.create(:client)
    end

    it 'returns a successful response, without custom fields' do
      params = {
        building: {
          street_1: '1100 S Congress Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704'
        }
      }

      post client_buildings_path(@client.id, params:, format: :json)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a successful response, with custom fields' do
      CustomField.create!(
        name: 'some_custom_field',
        display_name: 'A field that is custom',
        field_type: :number,
        client: @client
      )

      params = {
        building: {
          street_1: '1100 S Congress Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704',
          custom_fields: { some_custom_field: '100' }
        }
      }

      post client_buildings_path(@client.id, params:, format: :json)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a failed response when custom fields are invalid' do
      params = {
        building: {
          street_1: '1100 S Congress Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704',
          custom_fields: { not_yet_created: 20 }
        }
      }

      post client_buildings_path(@client.id, params:, format: :json)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns failed response when custom field is valid but value is not' do
      CustomField.create!(
        name: 'some_custom_field',
        display_name: 'A field that is custom',
        field_type: :number,
        client: @client
      )

      params = {
        building: {
          street_1: '1100 S Congress Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704',
          custom_fields: { some_custom_field: 'not a number' }
        }
      }

      expected_error = 'invalid value for number field type: not a number'
      post client_buildings_path(@client.id, params:, format: :json)
      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_body['base'].first).to eq(expected_error)
    end
  end

  describe 'PUT /update' do
    before do
      @building = FactoryBot.create(:building)
      @client = @building.client
    end

    it 'returns a successful response, without custom fields' do
      params = {
        building: {
          street_1: '123 Updated Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704'
        }
      }

      put client_building_path(@client.id, @building.id, params:, format: :json)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a successful response, with custom fields' do
      CustomField.create!(
        name: 'some_custom_field',
        display_name: 'A field that is custom',
        field_type: :number,
        client: @client
      )

      params = {
        building: {
          street_1: '123 Updated Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704',
          custom_fields: { some_custom_field: '100' }
        }
      }

      put client_building_path(@client.id, @building.id, params:, format: :json)
      expect(response).to have_http_status(:ok)
    end

    it 'returns a failed response when custom fields are invalid' do
      params = {
        building: {
          street_1: '123 Updated Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704',
          custom_fields: { not_yet_created: 20 }
        }
      }

      put client_building_path(@client.id, @building.id, params:, format: :json)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns failed response when custom field is valid but value is not' do
      CustomField.create!(
        name: 'some_custom_field',
        display_name: 'A field that is custom',
        field_type: :number,
        client: @client
      )

      params = {
        building: {
          street_1: '1100 S Congress Ave',
          city: 'Austin',
          state: 'TX',
          zipcode: '78704',
          custom_fields: { some_custom_field: 'not a number' }
        }
      }

      expected_error = 'invalid value for number field type: not a number'
      put client_building_path(@client.id, @building.id, params:, format: :json)
      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_body['base'].first).to eq(expected_error)
    end
  end
end
