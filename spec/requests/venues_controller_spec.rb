# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VenuesController', type: :request do
  describe 'POST /api/venues' do
    context 'post venues successfully' do
      let(:valid_venue) do
        { venue: FactoryBot.attributes_for(:venue) }
      end

      let(:message) do
        {
          "message" => I18n.t("venue.new.valid"),
          "status" => I18n.t("status.success"),
          "venue_id"=> Venue.last.id
        }
      end

      let(:seats_count) do
        valid_venue.dig(:venue, :rows).to_i * valid_venue.dig(:venue, :columns).to_i
      end

      it 'post venues with status code 200' do
        post '/api/venues', params: valid_venue
        expect(response).to have_http_status(200)
      end

      it 'renders successful message' do
        post '/api/venues', params: valid_venue
        expect(JSON.parse(response.body)).to eq(message)
      end

      it 'post venues successfully' do
        expect{
          post '/api/venues', params: valid_venue
        }.to change(Venue, :count).by (1)
      end

      it 'check if seats count is correct' do
        post '/api/venues', params: valid_venue
        expect(Seat.count).to eq(seats_count)
      end
    end

    context 'post venues with error' do
      let(:invalid_venue) do
        { venue: { rows: 1, columns: 1 } }
      end

      let(:message) do
        {
          "message" => I18n.t("venue.new.invalid"),
          "status" => I18n.t("status.error")
        }
      end

      it 'post venues with status code 422' do
        post '/api/venues', params: invalid_venue
        expect(response).to have_http_status(422)
      end

      it 'renders error message' do
        post '/api/venues', params: invalid_venue
        expect(JSON.parse(response.body)).to eq(message)
      end

      it 'check if seats doesn`t exist' do
        post '/api/venues', params: invalid_venue
        expect(Seat.count).to eq(0)
      end
    end
  end
end
