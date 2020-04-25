require 'rails_helper'

RSpec.describe Venue, type: :model do
  it { is_expected.to have_many(:seats) }
  it { is_expected.to validate_presence_of(:name)}
  it { is_expected.to validate_presence_of(:rows)}
  it { is_expected.to validate_presence_of(:columns)}
end
