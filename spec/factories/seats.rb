FactoryBot.define do
  factory :seat do
    row { 1 }
    column { 1 }
    label { "A1" }
    status { 0 }
  end
end
