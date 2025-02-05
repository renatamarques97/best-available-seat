module BestSeats
  class Finder
    INITIAL_ROW = "A"
    INITIAL_ROW_INDEX = 0
    INITIAL_COLUMN_INDEX = 1
    INITIAL_SET_INDEX = 0
    DENOMINATOR = 2.0

    attr_reader :params, :seats_requested

    def initialize(venue_id, seats_requested)
      @venue_id = venue_id
      @seats_requested = seats_requested.to_i
    end

    def all
      selected_seats = []

      available_seats_matrix.each do |line|
        next if insuficient_seats?(line.size)
        return selected_seats.sort if enough_selected?(selected_seats.size) && consecutive_values?(selected_seats)

        selected_seats = []

        (INITIAL_SET_INDEX...seats_requested).each do |seat|
          index = index_to_remove(line)
          value = line.delete_at(index)
          selected_seats << value
        end
      end

      selected_seats.sort
    end

    private

    def available_seats_matrix
      matrix.map do |row|
        row.delete_if { |column| !seats.include?(column.to_s.upcase) }
      end.delete_if(&:empty?)
    end

    def insuficient_seats?(total)
      total < seats_requested
    end

    def enough_selected?(selected_count)
      selected_count == seats_requested
    end

    def consecutive_values?(selected_seats)
      sorted_values = selected_seats.sort
      size = sorted_values.size

      sorted_values.delete_if.with_index do |value, index|
        if index < size - 1
          value.next == sorted_values[index+1]
        else
          true
        end
      end

      sorted_values.empty?
    end

    def index_to_remove(collection)
      sorted = collection.sort
      mid = (sorted.size - 1) / DENOMINATOR
      ((mid.floor + mid.ceil) / DENOMINATOR).to_i
    end

    def matrix
      return @_matrix if defined?(@_matrix)

      row_letter = INITIAL_ROW

      @_matrix = (INITIAL_ROW_INDEX...rows).map.with_index do |row, index|
        row_letter = index.zero? ? INITIAL_ROW : row_letter.next

        (INITIAL_COLUMN_INDEX..columns).map do |column|
          "#{row_letter}#{column}"
        end
      end
    end

    def rows
      @_rows ||= Seat.where(venue_id: @venue_id, available: true).map { |seat| seat.row }.count
    end

    def columns
      @_columns ||= Seat.where(venue_id: @venue_id, available: true).map { |seat| seat.column }.count
    end

    def seats
      @_seats ||= Seat.where(venue_id: @venue_id, available: true).map { |seat| seat.label }
    end
  end
end
