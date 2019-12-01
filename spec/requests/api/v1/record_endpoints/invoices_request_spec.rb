require 'rails_helper'

describe 'Invoices API' do
  before(:each) do
    create_list(:invoice, 3)
  end

  it 'sends a list of invoices' do
    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(3)
  end

  it 'can get one invoice by its id' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice['data']['id'].to_i).to eq(id)
  end

  #Single finders
  it 'can find a invoice by passing an id query param' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data']['attributes']['id']).to eq(invoice.id)
  end

  it 'can find a invoice by passing a customer_id query param' do
    customer_id = create(:customer).id
    invoice = create(:invoice, customer_id: customer_id)
    create(:invoice, customer_id: customer_id)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data']['attributes']['customer_id']).to eq(invoice.customer_id)
    expect(invoice_json['data']['attributes']['id']).to eq(invoice.id)
  end

  it 'can find a invoice by passing a merchant_id query param' do
    merchant_id = create(:merchant).id
    invoice = create(:invoice, merchant_id: merchant_id)
    create(:invoice, merchant_id: merchant_id)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data']['attributes']['merchant_id']).to eq(invoice.merchant_id)
    expect(invoice_json['data']['attributes']['id']).to eq(invoice.id)
  end

  it 'can find a invoice by passing a status query param' do
    invoice = Invoice.last

    get "/api/v1/invoices/find?status=#{invoice.status}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data']['attributes']['status']).to eq(invoice.status)
    expect(invoice_json['data']['id'].to_i).to eq(Invoice.first.id)
  end

  it 'can find a invoice by passing a created_at query param' do
    invoice = create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data']['id'].to_i).to eq(invoice.id)
  end

  it 'can find a invoice by passing an updated_at query param' do
    invoice = create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data']['id'].to_i).to eq(invoice.id)
  end

  #Multi-finders
  it 'can find all invoices for a given id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find_all?id=#{invoice.id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data'].count).to eq(1)
  end

  it 'can find all invoices for a given customer_id' do
    customer_id = create(:customer).id
    customer_id_2 = create(:customer).id
    invoice = create(:invoice, customer_id: customer_id)
    create(:invoice, customer_id: customer_id )
    create(:invoice, customer_id: customer_id_2)

    get "/api/v1/invoices/find_all?customer_id=#{invoice.customer_id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data'].count).to eq(2)
  end

  it 'can find all invoices for a given merchant_id' do
    merchant_id = create(:merchant).id
    invoice = create(:invoice, merchant_id: merchant_id)
    create(:invoice, merchant_id: merchant_id)
    create(:invoice, merchant_id: merchant_id)

    get "/api/v1/invoices/find_all?merchant_id=#{invoice.merchant_id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data'].count).to eq(3)
  end

  it 'can find all invoices for a given status' do
    invoice = create(:invoice, status: 0)

    get "/api/v1/invoices/find_all?status=#{invoice.status}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data'].count).to eq(4)
  end

  it 'can find all invoices for a given created_at date' do
    invoice_1 = create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data'].count).to eq(3)
  end

  it 'can find all invoices for a given updated_at date' do
    invoice_1 = create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:invoice, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoices/find_all?updated_at=#{invoice_1.updated_at}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json['data'].count).to eq(2)
  end

  #Random finder
  it 'can return a random resource' do
    get "/api/v1/invoices/random"
    invoice_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_json.count).to eq(1)
  end
end
