FactoryBot.define do
  factory :merchant do
    sequence(:name) { |i| "Dog Shop#{i}" }

    trait :with_items do
      transient do
        items_count { 3 }
      end

      after(:create) do |merchant, evaluator|
        merchant.items << create_list(:item, evaluator.items_count)
      end
    end

    trait :with_invoices do
      transient do
        invoices_count { 3 }
      end

      after(:create) do |merchant, evaluator|
        merchant.invoices << create_list(:invoice, evaluator.invoices_count)
      end
    end
  end
end
