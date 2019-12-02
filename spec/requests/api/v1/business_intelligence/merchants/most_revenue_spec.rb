require 'rails_helper'

describe 'Merchants with the most revenue API' do
  before(:each) do
    FactoryBot.rewind_sequences
  end
  it 'returns the top x merchants ranked by total revenue' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id)
    invoice_3 = create(:invoice, merchant_id: merchant_1.id)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, quantity: 2, unit_price: 10.00)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, quantity: 3, unit_price: 20.00)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_3.id, quantity: 4, unit_price: 30.50)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_1 = create(:transaction, invoice_id: invoice_2.id)
    transaction_1 = create(:transaction, invoice_id: invoice_3.id)

    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)['data']
    
    expect(merchants.count).to eq(2)
  end
end
