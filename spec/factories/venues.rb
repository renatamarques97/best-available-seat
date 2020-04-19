FactoryBot.define do
  factory :venue do
    name { FFaker::Venue.name }
    rows { FFaker::Random.rand(1..20) }
    columns { FFaker::Random.rand(1..20) }
  end
end
