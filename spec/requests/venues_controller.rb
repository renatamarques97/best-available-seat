# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VenuesController', type: :request do
  describe 'POST /api/venues' do
    context 'post venues successfully' do
      let(:valid_venue) do
        {
          venue: {
            name: 'Theater',
            rows: 3,
            columns: 3
          }
        }
      end

      it "post venues with status code 200" do
        post '/api/venues', params: valid_venue
        expect(response).to have_http_status(200)
      end

      it "post venues successfully" do
        expect{
          post '/api/venues', params: valid_venue
        }.to change(Venue, :count).by (1)
      end
    end
  end
end
