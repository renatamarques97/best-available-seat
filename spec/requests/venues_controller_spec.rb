# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VenuesController', type: :request do
  describe 'POST /api/venues' do
    context 'post venues successfully' do
      let(:valid_venue) do
        { venue: FactoryBot.attributes_for(:venue) }
      end

      let(:seats_count) do
        valid_venue.dig(:venue, :rows).to_i * valid_venue.dig(:venue, :columns).to_i
      end

      it 'post venues with status code 200' do
        post '/api/venues', params: valid_venue
        expect(response).to have_http_status(200)
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
  end
end
