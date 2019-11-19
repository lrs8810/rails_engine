FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |i| "Laura#{i}" }
    sequence(:last_name) { |i| "Schulz#{i}" }
  end
end
