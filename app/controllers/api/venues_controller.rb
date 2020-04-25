# frozen_string_literal: true

module Api
  class VenuesController < ApplicationController
    def index
      @venues = Venue.all

      render json: @venues
    end

    def create
      creator = VenueCreator.new(params: venue_params)

      if creator.perform
        render json: {
          status: t('status.success'),
          message: t('venue.new.valid'),
          venue_id: creator.venue.id,
        }, status: :ok
      else
        render json: {
          status: t('status.error'),
          message: t('venue.new.invalid')
        }, status: :unprocessable_entity
      end
    end

    private

    def venue_params
      params.require(:venue).permit(:name, :rows, :columns)
    end
  end
end
