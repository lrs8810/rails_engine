require 'rails_helper'

describe 'Items API' do
  before(:each) do
    create_list(:item, 3)
  end

  it 'sends a list of items' do
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id'].to_i).to eq(id)
  end

  #Single finders
  xit 'can find a item by passing a first name query param' do
    item = create(:item, first_name: "Sam", last_name: "Bee")

    get "/api/v1/items/find?first_name=#{item.first_name}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['first_name']).to eq(item.first_name)
  end

  xit 'can find a item by passing a last name query param' do
    item = create(:item, first_name: "Sam", last_name: "Bee")

    get "/api/v1/items/find?last_name=#{item.last_name}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['last_name']).to eq(item.last_name)
  end

  xit 'can find a item by query param regardless of string case' do
    item = create(:item, first_name: "Sam", last_name: "Bee")

    get "/api/v1/items/find?first_name=#{item.first_name.upcase}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['first_name']).to eq(item.first_name)
  end

  xit 'can find a item by passing an id query param' do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['id']).to eq(item.id)
  end

  xit 'can find a item by passing a created_at query param' do
    item = create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/items/find?created_at=#{item.created_at}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['id'].to_i).to eq(item.id)
  end

  xit 'can find a item by passing an updated_at query param' do
    item = create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['id'].to_i).to eq(customer.id)
  end

  #Multi-finders
  xit 'can find all customers for a given first name' do
    customer = create(:customer, first_name: "Sam")
    create(:customer, first_name: "Sam" )
    create(:customer, first_name: "Charlie")

    get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(2)
  end

  xit 'can find all customers for a given last name' do
    customer = create(:customer, last_name: "Bee")
    create(:customer, last_name: "Bee" )
    create(:customer, last_name: "Bee")
    create(:customer, last_name: "Charlie")

    get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(3)
  end

  xit 'can find all customers for a given id' do
    customer = create(:customer, first_name: 'Sam', last_name: 'Bee')

    get "/api/v1/customers/find_all?id=#{customer.id}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(1)
  end

  xit 'can find all customers for a given created_at date' do
    customer_1 = create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(3)
  end

  xit 'can find all customers for a given updated_at date' do
    customer_1 = create(:customer, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:customer, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"

    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json['data'].count).to eq(2)
  end

  #Random finder
  xit 'can return a random resource' do
    get "/api/v1/customers/random"
    customer_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer_json.count).to eq(1)
  end
end
