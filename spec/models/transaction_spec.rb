require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:result) }
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_numericality_of(:credit_card_number) }
    it { should validate_length_of(:credit_card_number).is_equal_to(16) }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'result' do
    it 'successful transaction' do
      transaction = create(:transaction, result: 0)

      expect(transaction.result).to eq('success')
    end

    it 'failed transaction' do
      transaction = create(:transaction, result: 1)

      expect(transaction.result).to eq('failed')
    end
  end
end
