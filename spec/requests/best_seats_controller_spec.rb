# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BestSeatsController', type: :request do
  describe 'GET /api/best_seats' do
    context 'get best seat successfully' do
      let(:message) do
        {
          "data" => ['A2'],
          "message" => I18n.t('best_seat.valid'),
          "status" => I18n.t('status.success')
        }
      end

      let(:venue) do
        { name: 'Venue', rows: 1, columns: 3 }
      end

      let(:seats_requested) { 1 }

      let(:venue_id) { Venue.last.id }

      before do
        VenueCreator.new(params: venue).perform
      end

      it 'get best seat with status code 200' do
        get "/api/best_seats?venue_id=#{venue_id}&seats_requested=#{seats_requested}"
        expect(response).to have_http_status(200)
      end

      it 'render successful message' do
        get "/api/best_seats?venue_id=#{venue_id}&seats_requested=#{seats_requested}"
        expect(JSON.parse(response.body)).to eq(message)
      end

      it 'call service successfully' do
        expect(BestSeats::Finder).to receive(:new).with(venue_id.to_s,seats_requested.to_s).and_call_original
        get "/api/best_seats?venue_id=#{venue_id}&seats_requested=#{seats_requested}"
      end
    end
  end
end
