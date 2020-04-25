class Venue < ApplicationRecord
  has_many :seats, dependent: :destroy
  validates :name, :rows, :columns, presence: true
end
