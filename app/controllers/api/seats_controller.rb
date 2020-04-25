# frozen_string_literal: true

module Api
  class SeatsController < ApplicationController
    def index
      seats = Seat.where(venue_id: params[:venue_id])
      render json: seats
    end

    def update
      seat = Seat.find(params[:id])
      status = params.permit(:available)
      bool = params[:available].in? ["true", "false"]

      if (seat.update(status)) && bool
        render json: {
          status: t('status.success'),
          message: t('seat.update.valid')
        }, status: :ok
      else
        render json: {
          status: t('status.error'),
          message: t('seat.update.invalid')
        }, status: :unprocessable_entity
      end
    end
  end
end
