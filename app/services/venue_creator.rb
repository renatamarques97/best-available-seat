# frozen_string_literal: true

class VenueCreator
  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def perform
    ActiveRecord::Base.transaction do
      create_seats

      venue
    end
  end

  private

  def venue
    @venue ||= Venue.create!
  end

  def create_seats
    venue_params.each do |venue|
      for row in 1..venue[:rows]
        for column in 1..venue[:columns]
          Seat.create!(
            row: row,
            column: column,
            status: 1,
            label: "#{row}#{column}",
            venue_id: venue.id)
        end
      end
    end
  end

  def venue_params
    @venue_params ||= params[:venue]
  end
end
