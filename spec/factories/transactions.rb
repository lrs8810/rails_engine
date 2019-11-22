FactoryBot.define do
  factory :transaction do
    sequence(:credit_card_number) { |n| "123456789101112#{n}" }
    result { 0 }
    invoice
  end
end
