class Venue < ApplicationRecord
  has_many :seats
  validates :name, :rows, :columns, presence: true
end
