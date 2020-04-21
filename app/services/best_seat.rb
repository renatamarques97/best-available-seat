# frozen_string_literal: true

class BestSeat
  attr_reader :params

  def initialize(venue_id:)
    @venue_id = venue_id
  end

  def query
    @query ||= Seat.where(venue_id: @venue_id, available: true)
  end

  def perform(seats_num = 1)
    arr = Array.new
    query.each do |seat|
      arr << seat[:label]
    end
    mid = arr.length / 2
    arr.sort[mid..mid + seats_num - 1]
  end
end
