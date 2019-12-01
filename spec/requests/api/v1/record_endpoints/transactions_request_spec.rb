require 'rails_helper'

describe 'Transactions API' do
  before(:each) do
    FactoryBot.rewind_sequences
    create_list(:transaction, 3)
  end

  it 'sends a list of transactions' do
    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(3)
  end

  it 'can get one transaction by its id' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction['data']['id'].to_i).to eq(id)
  end

  #Single finders
  it 'can find a transaction by passing an id query param' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data']['attributes']['id']).to eq(transaction.id)
  end

  it 'can find a transaction by passing a invoice_id query param' do
    invoice_id = create(:invoice).id
    transaction = create(:transaction, invoice_id: invoice_id)
    create(:transaction, invoice_id: invoice_id)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data']['attributes']['invoice_id']).to eq(transaction.invoice_id)
    expect(transaction_json['data']['attributes']['id']).to eq(transaction.id)
  end

  it 'can find a transaction by passing a credit_card_number query param' do
    transaction = create(:transaction, credit_card_number: "9876543211947639")
    create(:transaction, credit_card_number: "9876543211947639")

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data']['attributes']['credit_card_number']).to eq(transaction.credit_card_number)
    expect(transaction_json['data']['attributes']['id']).to eq(transaction.id)
  end

  it 'can find a transaction by passing a result query param' do
    transaction = Transaction.last

    get "/api/v1/transactions/find?result=#{transaction.result}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data']['attributes']['result']).to eq(transaction.result)
    expect(transaction_json['data']['id'].to_i).to eq(Transaction.first.id)
  end

  it 'can find a transaction by passing a created_at query param' do
    transaction = create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data']['id'].to_i).to eq(transaction.id)
  end

  it 'can find a transaction by passing an updated_at query param' do
    transaction = create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data']['id'].to_i).to eq(transaction.id)
  end

  #Multi-finders
  it 'can find all transactions for a given id' do
    transaction = create(:transaction)

    get "/api/v1/transactions/find_all?id=#{transaction.id}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data'].count).to eq(1)
  end

  it 'can find all transactions for a given invoice_id' do
    invoice_id = create(:invoice).id
    invoice_id_2 = create(:invoice).id
    transaction = create(:transaction, invoice_id: invoice_id)
    create(:transaction, invoice_id: invoice_id )
    create(:transaction, invoice_id: invoice_id_2)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction.invoice_id}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data'].count).to eq(2)
  end

  it 'can find all transactions for a given credit_card_number' do
    transaction = create(:transaction, credit_card_number: "9876543211947639")
    create(:transaction, credit_card_number: "9876543211947639")
    create(:transaction, credit_card_number: "9876543211947639")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction.credit_card_number}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data'].count).to eq(3)
  end

  it 'can find all transactions for a given result' do
    transaction = create(:transaction, result: 0)

    get "/api/v1/transactions/find_all?result=#{transaction.result}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data'].count).to eq(4)
  end

  it 'can find all transactions for a given created_at date' do
    transaction_1 = create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data'].count).to eq(3)
  end

  it 'can find all transactions for a given updated_at date' do
    transaction_1 = create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:transaction, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/transactions/find_all?updated_at=#{transaction_1.updated_at}"

    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json['data'].count).to eq(2)
  end

  #Random finder
  it 'can return a random resource' do
    get "/api/v1/transactions/random"
    transaction_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction_json.count).to eq(1)
  end
end
