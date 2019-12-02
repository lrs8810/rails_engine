require 'rails_helper'

describe 'Transactions Relationships API' do
  it 'returns the associated invoice for a specific transaction' do
    FactoryBot.rewind_sequences
    transaction = create(:transaction)
    invoice_id = transaction.invoice_id

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)['data']

    expect(invoice['attributes']['id']).to eq(invoice_id)
    expect(invoice['type']).to eq('invoice')
  end
end
