# frozen_string_literal: true

module Api
  class BestSeatsController < ApplicationController
    def index
      best_seat = BestSeat.new(venue_id: params[:venue_id])

      render json: {
        status: t('status.success'),
        message: t('best_seat.valid'),
        data: best_seat.perform
      }, status: :ok
    end
  end
end

