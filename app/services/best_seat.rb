# frozen_string_literal: true

class BestSeat
  attr_reader :params

  def initialize(venue_id:, seats_requested:)
    @venue_id = venue_id
    @seats_requested = seats_requested
  end

  def query
    @query ||= Seat.where(venue_id: @venue_id, available: true)
  end

  def perform(seats_requested = 1)
    arr = Array.new
    query.each do |seat|
      arr << seat[:label]
    end
    mid = arr.length / 2
    arr.sort[mid..mid + seats_requested - 1]
  end
end
