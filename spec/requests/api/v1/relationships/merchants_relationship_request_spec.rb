require 'rails_helper'

describe 'Merchants Relationships API' do
  it 'returns a collection of items for a specific merchant' do
    merchant = create(:merchant, :with_items)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    merchant_items = JSON.parse(response.body)
    expect(merchant_items['data'].count).to eq(3)
  end

  it 'returns a collection of invoices for a specific merchant' do
    merchant = create(:merchant, :with_invoices)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful
    merchant_invoices = JSON.parse(response.body)
    expect(merchant_invoices['data'].count).to eq(3)
  end
end
