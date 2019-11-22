class Transaction < ApplicationRecord
  validates_presence_of :result,
                        :credit_card_number

  validates_length_of :credit_card_number, is: 16
  validates_numericality_of :credit_card_number

  belongs_to :invoice

  enum result: %w(success failed)
end
