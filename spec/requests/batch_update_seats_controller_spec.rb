# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BatchUpdateSeatsController', type: :request do
  describe 'POST /api/batch_update_seats' do
    context 'post batch update seats successfully' do
      let(:venue) do
       { name: 'Venue', rows: 1, columns: 2 }
      end

      before do
        VenueCreator.new(params: venue).perform
      end

      let(:first_seat) { Seat.first }
      let(:last_seat) { Seat.last }

      let(:batch) do
        { seats_ids: [first_seat.id, last_seat.id], available: false }
      end

      it 'status code 200' do
        post '/api/batch_update_seats', params: batch
        expect(response).to have_http_status(200)
      end

      it 'updating a batch of seats' do
        post '/api/batch_update_seats', params: batch
        expect(first_seat.reload.available).to eq(false)
        expect(last_seat.reload.available).to eq(false)
      end

      let(:message) do
        {
          "message" => I18n.t("seat.update.valid"),
          "status" => I18n.t("status.success")
        }
      end

      it 'render successful message' do
        post '/api/batch_update_seats', params: batch
        expect(JSON.parse(response.body)).to eq(message)
      end
    end
  end
end
