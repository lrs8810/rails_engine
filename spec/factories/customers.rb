FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |i| "Laura#{i}" }
    sequence(:last_name) { |i| "Schulz#{i}" }

    trait :with_invoices do
      transient do
        invoice_count { 3 }
      end

      after(:create) do |customer, evaluator|
        customer.invoices << create_list(:invoice, evaluator.invoice_count)
      end
    end
  end
end
