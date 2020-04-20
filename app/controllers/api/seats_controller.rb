# frozen_string_literal: true

module Api
  class SeatsController < ApplicationController
    def update
      seat = Seat.find(params[:id])
      status = params.permit(:status)

      if (seat.update(status))
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
