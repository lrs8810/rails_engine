require 'rails_helper'

describe 'Merchants Relationships API' do
  it 'returns a collection of items for a specific merchant' do
    merchant = create(:merchant, :with_items)
    create(:merchant, :with_items, items_count: 2)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    merchant_items = JSON.parse(response.body)['data']

    merchant_items.each do |item|
      expect(item['attributes']['merchant_id']).to eq(merchant.id)
    end

    merchant_items.each do |item|
      expect(item['type']).to eq("item")
    end

    expect(merchant_items).to be_a(Array)
    expect(merchant_items.count).to eq(3)
  end

  it 'returns a collection of invoices for a specific merchant' do
    merchant = create(:merchant, :with_invoices)
    create(:merchant, :with_invoices, )

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful
    merchant_invoices = JSON.parse(response.body)['data']

    merchant_invoices.each do |invoice|
      expect(invoice['attributes']['merchant_id']).to eq(merchant.id)
    end

    merchant_invoices.each do |invoice|
      expect(invoice['type']).to eq("invoice")
    end

    expect(merchant_invoices).to be_a(Array)
    expect(merchant_invoices.count).to eq(3)
  end
end
