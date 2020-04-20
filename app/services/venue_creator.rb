# frozen_string_literal: true

class VenueCreator
  INITIAL_LETTER = 'A'

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def perform
    return false if invalid?

    ActiveRecord::Base.transaction do
      create_seats
    end
  end

  private

  def venue
    @venue ||= Venue.create(params)
  end

  def create_seats
    row_letter = INITIAL_LETTER
    1.upto(venue.rows) do
      for column in 1..venue.columns
        Seat.create!(
          row: row_letter,
          column: column,
          available: true,
          label: "#{row_letter}#{column}",
          venue_id: venue.id)
      end
      row_letter = row_letter.next
    end
  end

  def invalid?
    venue.name.nil? || venue.rows.nil? || venue.columns.nil?
  end
end
