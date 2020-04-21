# frozen_string_literal: true

module Api
  class BestSeatsController < ApplicationController
    def index
      best_seat = BestSeats::Finder.new(params[:venue_id], params[:seats_requested])

      render json: {
        status: t('status.success'),
        message: t('best_seat.valid'),
        data: best_seat.all,
      }, status: :ok
    end
  end
end

