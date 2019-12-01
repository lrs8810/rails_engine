FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity) { |n| "#{n}" }
    sequence(:unit_price, 50) { |n| n + 1.50  }
    invoice
    item
  end
end
