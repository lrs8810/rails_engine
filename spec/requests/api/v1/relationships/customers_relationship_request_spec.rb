require 'rails_helper'

describe 'Customers Relationships API' do
  it 'returns a collection of invoices for a specific customer' do
    customer = create(:customer, :with_invoices, invoice_count: 4)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)['data']

    invoices.each do |invoice|
      expect(invoice['attributes']['customer_id']).to eq(customer.id)
    end

    invoices.each do |invoice|
      expect(invoice['type']).to eq("invoice")
    end

    expect(invoices).to be_a(Array)
    expect(invoices.count).to eq(4)
  end

  it 'returns a collection of transactions for a specific invoice' do
    FactoryBot.rewind_sequences
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id)
    invoice_3 = create(:invoice, customer_id: customer_2.id)
    invoice_1.transactions.push(create_list(:transaction, 3))
    invoice_2.transactions.push(create_list(:transaction, 2))
    invoice_3.transactions.push(create_list(:transaction, 4))

    get "/api/v1/customers/#{customer_1.id}/transactions"

    expect(response).to be_successful
    transactions = JSON.parse(response.body)['data']

    transactions.each do |transaction|
      expect(transaction['type']).to eq("transaction")
    end

    expect(transactions).to be_a(Array)
    expect(transactions.count).to eq(5)
  end

end
