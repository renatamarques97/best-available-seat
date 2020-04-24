module Api
  class BatchUpdateSeatsController < ApplicationController
    def create
      seat = Seat.where(id: params[:seats_ids]).update_all(available: params[:available])

      if seat
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
