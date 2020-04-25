# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueCreator, type: :service do
  describe 'creates venue with seats' do
    context 'creates venue successfully' do
      let(:valid_venue) do
        FactoryBot.attributes_for(:venue)
      end

      let(:seats_count) do
        valid_venue.dig(:rows).to_i * valid_venue.dig(:columns).to_i
      end

      it 'creates venue with method .perform' do
        expect(described_class.new(params: valid_venue).perform).to eq(true)
      end

      it 'changes venue`s count by 1' do
        expect { described_class.new(params: valid_venue).perform }.to change { Venue.count }.by(1)
      end

      it 'changes count of seats' do
        expect { described_class.new(params: valid_venue).perform }.to change { Seat.count }.by(seats_count)
      end

      it 'creates seat`s label' do
        described_class.new(params: valid_venue).perform
        expect(Seat.first.label).to eq('A1')
      end
    end

    context 'does not create venue' do
      let(:invalid_venue) do
        { rows: 1, columns: 1 }
      end

      it 'does not create venue with invalid params' do
        expect(described_class.new(params: invalid_venue).perform).to eq(false)
      end

      it 'does not change count' do
        expect { described_class.new(params: invalid_venue).perform }.to_not change { Venue.count }
      end

      it 'does not change count of seats' do
        expect { described_class.new(params: invalid_venue).perform }.to_not change { Seat.count }
      end
    end
  end
end

