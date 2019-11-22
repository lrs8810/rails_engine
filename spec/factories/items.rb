FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Dog Bone#{n}" }
    sequence(:description) { |n| "This is the best bone#{n}" }
    unit_price { 350.50 }
    merchant
  end
end
