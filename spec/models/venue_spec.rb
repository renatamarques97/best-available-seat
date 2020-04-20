require 'rails_helper'

RSpec.describe Venue, type: :model do
  it { is_expected.to have_many(:seats) }
end
