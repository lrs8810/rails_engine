require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should_not allow_value(nil).for(:result) }
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end
end
