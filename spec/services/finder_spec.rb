# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BestSeats::Finder, type: :service do
  describe '#all' do
    subject { described_class.new(venue_id, seats_requested)}

    context 'when one seat is requested' do
      let(:seats_requested) { 1 }

      let(:venue) do
        { name: 'Venue', rows: 1, columns: 3 }
      end

      let(:venue_id) do
        Venue.last.id
      end

      before do
        VenueCreator.new(params: venue).perform
      end

      it 'returns the correct value' do
        expect(subject.all).to eq(["A2"])
      end
    end

    context 'when two seats are requested' do
      let(:seats_requested) { 2 }

      let(:venue) do
        { name: 'Venue', rows: 4, columns: 4}
      end

      let(:venue_id) do
        Venue.last.id
      end

      before do
        VenueCreator.new(params: venue).perform
      end

      it 'returns the correct value' do
        expect(subject.all).to eq(["A2", "A3"])
      end
    end

    context 'when first line is full' do
      let(:seats_requested) { 2 }

      let(:venue) do
        { name: 'Venue', rows: 4, columns: 4}
      end

      let(:venue_id) do
        Venue.last.id
      end

      before do
        VenueCreator.new(params: venue).perform
      end

      let!(:first_row_occupied) do
        Seat.where(venue_id: venue_id, row: "A").each do |seat|
          seat.available = false
          seat.save
        end
      end

      it 'returns the correct value' do
        expect(subject.all).to eq(["B2", "B3"])
      end
    end

    context 'when first line doesn`t have consecutive seats' do
      let(:seats_requested) { 2 }

      let(:venue) do
        { name: 'Venue', rows: 4, columns: 4 }
      end

      let(:venue_id) do
        Venue.last.id
      end

      before do
        VenueCreator.new(params: venue).perform
      end

      let!(:first_row_without_consective_seats) do
       Seat.where(venue_id: venue_id, row: "A").each do |seat|
         next if seat.column.odd?

         seat.available = false
         seat.save
       end
      end

      it 'returns the correct value' do
        expect(subject.all).to eq(["B2", "B3"])
      end
    end
  end
end
