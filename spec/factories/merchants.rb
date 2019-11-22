FactoryBot.define do
  factory :merchant do
    sequence(:name) { |i| "Dog Shop#{i}" }
  end
end
