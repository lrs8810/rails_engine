FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Dog Bone#{n}" }
    sequence(:description) { |n| "This is the best bone#{n}" }
    unit_price { 350.50 }
    merchant

    trait :with_invoice_items do
      transient do
        invoice_item_count { 3 }
      end

      after(:create) do |item, evaluator|
        item.invoice_items << create_list(:invoice_item, evaluator.invoice_item_count)
      end
    end
  end
end
