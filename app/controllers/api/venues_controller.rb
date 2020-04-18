# frozen_string_literal: true

module Api
  class VenuesController < ApplicationController
    def create
      creator = VenueCreator.new(params: venue_params)

      if creator.perform
        render json: {
          status: 'status.success',
          message: 'venue.new.valid'
        }, status: :ok
      else
        render json: {
          status: 'status.error',
          message: 'venue.new.invalid'
        }, status: :unprocessable_entity
      end
    end

    private

    def venue_params
      params.require(:venue).permit(:name, :rows, :columns)
    end
  end
end
