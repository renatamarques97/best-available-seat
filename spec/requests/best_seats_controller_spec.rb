# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BestSeatsController', type: :request do
  describe 'GET /api/best_seats' do
    context 'get best seat successfully' do
      let(:message) do
        {
          "data" => [],
          "message" => I18n.t('best_seat.valid'),
          "status" => I18n.t('status.success')
        }
      end

      it 'get best seat with status code 200' do
        get '/api/best_seats'
        expect(response).to have_http_status(200)
      end

      it 'render successful message' do
        get '/api/best_seats'
        expect(JSON.parse(response.body)).to eq(message)
      end
    end
  end
end