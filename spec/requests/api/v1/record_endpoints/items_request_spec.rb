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
  it 'can find a item by passing a name query param' do
    item = create(:item, name: "Leash")

    get "/api/v1/items/find?name=#{item.name}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['name']).to eq(item.name)
  end

  it 'can find a item by passing a description query param' do
    item = create(:item, description: "This is the best item on our site")

    get "/api/v1/items/find?description=#{item.description}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['description']).to eq(item.description)
  end

  it 'can find a item by query param regardless of string case' do
    item = create(:item, name: 'Lease')

    get "/api/v1/items/find?name=#{item.name.upcase}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['name']).to eq(item.name)
  end

  it 'can find a item by passing an id query param' do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['id']).to eq(item.id)
  end

  it 'can find a item by passing an unit_price query param' do
    item = create(:item, unit_price: "253.40")

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['unit_price']).to eq(item.unit_price.to_s)
  end

  it 'can find a item by passing a merchant_id query param' do
    merchant_id = create(:merchant).id
    item = create(:item, merchant_id: merchant_id)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['attributes']['merchant_id']).to eq(item.merchant_id)
  end

  it 'can find a item by passing a created_at query param' do
    item = create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/items/find?created_at=#{item.created_at}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['id'].to_i).to eq(item.id)
  end

  it 'can find a item by passing an updated_at query param' do
    item = create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data']['id'].to_i).to eq(item.id)
  end

  #Multi-finders
  it 'can find all items for a given name' do
    item = create(:item, name: "Leash")
    create(:item, name: "Leash" )
    create(:item, name: "Squeaky toy")

    get "/api/v1/items/find_all?name=#{item.name}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data'].count).to eq(2)
  end

  it 'can find all items for a given description' do
    item = create(:item, description: "This is the best item on the market")
    create(:item, description: "This is the best item on the market" )
    create(:item, description: "This is the best item on the market")
    create(:item, description: "It's okay")

    get "/api/v1/items/find_all?description=#{item.description}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data'].count).to eq(3)
  end

  it 'can find all items for a given id' do
    item = create(:item, name: 'Leash')

    get "/api/v1/items/find_all?id=#{item.id}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data'].count).to eq(1)
  end

  it 'can find all items for a given merchant_id' do
    merchant_id = create(:merchant).id
    item = create(:item, name: 'Leash', merchant_id: merchant_id)
    create(:item, name: 'Chew Toy', merchant_id: merchant_id)
    create(:item, name: 'Frisbee', merchant_id: merchant_id)

    get "/api/v1/items/find_all?merchant_id=#{item.merchant_id}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data'].count).to eq(3)
  end

  it 'can find all items for a given created_at date' do
    item_1 = create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data'].count).to eq(3)
  end

  it 'can find all items for a given updated_at date' do
    item_1 = create(:item, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:item, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json['data'].count).to eq(2)
  end

  #Random finder
  it 'can return a random resource' do
    get "/api/v1/items/random"
    item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_json.count).to eq(1)
  end
end
