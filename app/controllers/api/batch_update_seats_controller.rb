module Api
  class BatchUpdateSeatsController < ApplicationController
    def create
      Seat.where(id: params[:seats_ids]).update_all(available: params[:available])

      render json: {
        status: t('status.success'),
        message: t('seat.update.valid')
      }, status: :ok
    end
  end
end
