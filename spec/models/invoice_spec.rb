require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'associations' do
    it 'has many invoice_items' do
      invoice_1 = create(:invoice, :with_invoice_items, invoice_item_count: 3)

      expect(invoice_1.invoice_items.count).to eq(3)
    end

    it 'has many transactions' do
      invoice_1 = create(:invoice, :with_transactions, transaction_count: 3)

      expect(invoice_1.transactions.count).to eq(3)
    end

    it 'belongs to a customer' do
      invoice_1 = create(:invoice)

      expect(invoice_1.customer).to be_a(Customer)
    end

    it 'belongs to a merchant' do
      invoice_1 = create(:invoice)

      expect(invoice_1.merchant).to be_a(Merchant)
    end
  end

  describe 'status' do
    it 'can be created with default shipped' do
      invoice = create(:invoice)

      expect(invoice.status).to eq('shipped')
    end
  end
end
