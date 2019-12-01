require 'rails_helper'

describe 'Invoices Relationships API' do
  it 'returns a collection of transactions for a specific invoice' do
    invoice = create(:invoice, :with_transactions)
    create(:invoice, :with_transactions)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful
    invoice_transactions = JSON.parse(response.body)['data']

    invoice_transactions.each do |transaction|
      expect(transaction['attributes']['invoice_id']).to eq(invoice.id)
    end

    invoice_transactions.each do |transaction|
      expect(transaction['type']).to eq("transaction")
    end

    expect(invoice_transactions).to be_a(Array)
    expect(invoice_transactions.count).to eq(3)
  end

  it 'returns a collection of invoice_items for a specific invoice' do
    invoice = create(:invoice, :with_invoice_items)
    create(:invoice, :with_invoice_items)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful
    invoice_items = JSON.parse(response.body)['data']

    invoice_items.each do |invoice_item|
      expect(invoice_item['attributes']['invoice_id']).to eq(invoice.id)
    end

    invoice_items.each do |invoice_item|
      expect(invoice_item['type']).to eq("invoice_item")
    end

    expect(invoice_items).to be_a(Array)
    expect(invoice_items.count).to eq(3)
  end

  it 'returns a collection of items for a specific invoice' do
    invoice = create(:invoice, :with_invoice_items, invoice_item_count: 2)
    create(:invoice, :with_invoice_items)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body)['data']

    items.each do |item|
      expect(item['type']).to eq("item")
    end

    expect(items).to be_a(Array)
    expect(items.count).to eq(2)
  end

  it 'returns the associated customer for a specific invoice' do
    customer_id = create(:customer).id
    invoice = create(:invoice, customer_id: customer_id)
    create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful
    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(invoice.customer_id)
    expect(customer['type']).to eq('customer')
  end

  it 'returns the associated merchant for a specific invoice' do
    merchant_id = create(:merchant).id
    invoice = create(:invoice, merchant_id: merchant_id)
    create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)['data']

    expect(merchant['attributes']['id']).to eq(invoice.merchant_id)
    expect(merchant['type']).to eq('merchant')
  end
end
