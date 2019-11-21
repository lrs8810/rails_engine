class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  validates_inclusion_of :result, in: [true, false]

  belongs_to :invoice
end
