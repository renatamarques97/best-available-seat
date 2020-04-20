# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SeatsController', type: :request do
  describe 'PUT /api/seats' do
    context 'update status successfully' do
      let(:venue) do
        { venue: FactoryBot.attributes_for(:venue) }
      end

      let(:unavailable) do
        { available: false }
      end

      let(:message) do
        {
          "message" => I18n.t("seat.update.valid"),
          "status" => I18n.t("status.success")
        }
      end

      before do
        post '/api/venues', params: venue
      end

      it 'request with status code 200' do
        put '/api/seats/' + Seat.last.id.to_s, params: unavailable
        expect(response).to have_http_status(200)
      end

      it 'renders successful message' do
        put '/api/seats/' + Seat.last.id.to_s, params: unavailable
        expect(JSON.parse(response.body)).to eq(message)
      end
    end

    context 'do not update seats' do
      let(:venue) do
        { venue: FactoryBot.attributes_for(:venue) }
      end

      let(:invalid_param) { '1' }

      let(:unavailable) { { available: invalid_param } }

      let(:message) do
        {
          "message" => I18n.t("seat.update.invalid"),
          "status" => I18n.t("status.error")
        }
      end

      before do
        post '/api/venues', params: venue
      end

      it 'request with status code 422' do
        put '/api/seats/' + Seat.last.id.to_s, params: unavailable
        expect(response).to have_http_status(422)
      end

      it 'render error message' do
        put '/api/seats/' + Seat.last.id.to_s, params: unavailable
        expect(JSON.parse(response.body)).to eq(message)
      end

      it 'status has not changed' do
        put '/api/seats/' + Seat.last.id.to_s, params: unavailable
        expect(Seat.last.available).to_not eq(invalid_param)
      end
    end
  end
end
