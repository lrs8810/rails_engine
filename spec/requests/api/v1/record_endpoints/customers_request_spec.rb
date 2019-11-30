require 'rails_helper'

describe 'Customers API' do
  before(:each) do
    create_list(:customer, 3)
  end

  it 'sends a list of customers' do
    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers['data'].count).to eq(3)
  end

  it 'can get one customer by its id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer['data']['id'].to_i).to eq(id)
  end

  #Single finders
  it 'can find a customer by passing a first name query param' do
    customer = create(:customer, first_name: "Sam", last_name: "Bee")

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data']['attributes']['first_name']).to eq(customer.first_name)
  end

  it 'can find a customer by passing a last name query param' do
    customer = create(:customer, first_name: "Sam", last_name: "Bee")

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data']['attributes']['last_name']).to eq(customer.last_name)
  end

  it 'can find a customer by query param regardless of string case' do
    customer = create(:customer, first_name: "Sam", last_name: "Bee")

    get "/api/v1/customers/find?first_name=#{customer.first_name.upcase}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data']['attributes']['first_name']).to eq(customer.first_name)
  end

  it 'can find a customer by passing an id query param' do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data']['attributes']['id']).to eq(customer.id)
  end

  it 'can find a customer by passing a created_at query param' do
    customer = create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data']['id'].to_i).to eq(customer.id)
  end

  it 'can find a customer by passing an updated_at query param' do
    customer = create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data']['id'].to_i).to eq(customer.id)
  end

  #Multi-finders
  it 'can find all customers for a given first name' do
    customer = create(:customer, first_name: "Sam")
    create(:customer, first_name: "Sam" )
    create(:customer, first_name: "Charlie")

    get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(2)
  end

  it 'can find all customers for a given last name' do
    customer = create(:customer, last_name: "Bee")
    create(:customer, last_name: "Bee" )
    create(:customer, last_name: "Bee")
    create(:customer, last_name: "Charlie")

    get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(3)
  end

  it 'can find all customers for a given id' do
    customer = create(:customer, first_name: 'Sam', last_name: 'Bee')

    get "/api/v1/customers/find_all?id=#{customer.id}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(1)
  end

  it 'can find all customers for a given created_at date' do
    customer_1 = create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(3)
  end

  it 'can find all customers for a given updated_at date' do
    customer_1 = create(:customer, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(2)
  end

  #Random finder
  it 'can return a random resource' do
    get "/api/v1/customers/random"
    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json.count).to eq(1)
  end
end
