# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SeatsController', type: :request do
  describe 'PUT /api/seats' do
    context 'update status successfully' do
      let(:venue) do
        { venue: FactoryBot.attributes_for(:venue) }
      end

      let(:unavailable) do
        { status: 1 }
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
  end
end
