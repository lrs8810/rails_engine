FactoryBot.define do
  factory :merchant do
    sequence(:name) { |i| "Meg's Dog Shop#{i}" }
  end
end
