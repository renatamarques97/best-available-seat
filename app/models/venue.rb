class Venue < ApplicationRecord
  validates :name, :rows, :columns, presence: true
end
