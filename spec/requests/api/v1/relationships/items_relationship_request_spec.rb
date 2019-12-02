require 'rails_helper'

describe 'Items Relationships API' do
  it 'returns a collectio of the associated invoice_items for a specific item' do
    item = create(:item, :with_invoice_items, invoice_item_count: 2)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)['data']

    invoice_items.each do |invoice_item|
      expect(invoice_item['attributes']['item_id']).to eq(item.id)
    end

    invoice_items.each do |invoice_item|
      expect(invoice_item['type']).to eq('invoice_item')
    end

    expect(invoice_items).to be_a(Array)
    expect(invoice_items.count).to eq(2)
  end

  it 'returns the associated merchant for a specific item' do
    merchant_id = create(:merchant).id
    item = create(:item, merchant_id: merchant_id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['id']).to eq(item.merchant_id)
    expect(merchant['type']).to eq('merchant')
  end
end
