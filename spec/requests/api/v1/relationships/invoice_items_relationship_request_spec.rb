require 'rails_helper'

describe 'InvoiceItems Relationships API' do
  it 'returns the associated invoice for a specific invoice_item' do
    invoice_item = create(:invoice_item)
    invoice_id = invoice_item.invoice_id
    create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['id']).to eq(invoice_id)
    expect(invoice['type']).to eq('invoice')
  end

  it 'returns the associated item for a specific invoice_item' do
    invoice_item = create(:invoice_item)
    item_id = invoice_item.item_id
    create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful
    item = JSON.parse(response.body)['data']

    expect(item['attributes']['id']).to eq(item_id)
    expect(item['type']).to eq('item')
  end
end
