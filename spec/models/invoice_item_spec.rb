require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe 'associations' do
    before(:each) do
      @invoice_item = create(:invoice_item)
    end

    it 'belongs to an item' do
      expect(@invoice_item.item).to be_a(Item)
    end

    it 'belongs to an invoice' do
      expect(@invoice_item.invoice).to be_a(Invoice)
    end
  end
end
