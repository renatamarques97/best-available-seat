FactoryBot.define do
  factory :seat do
    row { 1 }
    column { 1 }
    label { "MyString" }
    status { 1 }
  end
end
