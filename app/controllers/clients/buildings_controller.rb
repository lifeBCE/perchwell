# frozen_string_literal: true

module Clients
  class BuildingsController < ApplicationController
    before_action :set_client
    before_action :set_building, only: :update

    # GET /clients/:client_id/buildings
    def index
      @buildings = @client
        .buildings
        .order(:id)
        .page(params[:page] || 1)
        .per(params[:per_page] || 10)
        .map { _1.index_response }
    end

    # POST /clients/:client_id/buildings
    def create
      building = @client.buildings.new(building_params)

      if building.save
        render json: { status: "success" }, status: :ok
      else
        render json: building.errors, status: :unprocessable_entity
      end
    end

    # PUT /clients/:client_id/buildings/:id
    def update
      if @building.update(building_params)
        render json: { status: "success" }, status: :ok
      else
        render json: @building.errors, status: :unprocessable_entity
      end
    end

    private

    def set_client
      @client = Client.find(params[:client_id])
    end

    def set_building
      @building = @client.buildings.find(params[:id])
    end

    def building_params
      params
        .require(:building)
        .permit(
          :street_1,
          :street_2,
          :city,
          :state,
          :zipcode,
          custom_fields: {}
        )
    end
  end
end
