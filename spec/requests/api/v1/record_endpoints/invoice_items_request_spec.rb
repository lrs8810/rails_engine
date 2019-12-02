require 'rails_helper'

describe 'InvoiceItems API' do
  before(:each) do
    FactoryBot.rewind_sequences
    create_list(:invoice_item, 3)
  end

  it 'sends a list of invoice_items' do
    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].count).to eq(3)
  end

  it 'can get one invoice_item by its id' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item['data']['id'].to_i).to eq(id)
  end

  #Single finders
  it 'can find a invoice_item by passing an id query param' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['attributes']['id']).to eq(invoice_item.id)
  end

  it 'can find a invoice_item by passing an item_id query param' do
    item_id = create(:item).id
    invoice_item = create(:invoice_item, item_id: item_id)
    create(:invoice_item, item_id: item_id)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['attributes']['item_id']).to eq(invoice_item.item_id)
    expect(invoice_item_json['data']['attributes']['id']).to eq(invoice_item.id)
  end

  it 'can find a invoice_item by passing an invoice_id query param' do
    invoice_id = create(:invoice).id
    invoice_item = create(:invoice_item, invoice_id: invoice_id)
    create(:invoice_item, invoice_id: invoice_id)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['attributes']['invoice_id']).to eq(invoice_item.invoice_id)
    expect(invoice_item_json['data']['attributes']['id']).to eq(invoice_item.id)
  end

  it 'can find a invoice_item by passing a quantity query param' do
    invoice_item = create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 5)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['attributes']['quantity']).to eq(invoice_item.quantity)
    expect(invoice_item_json['data']['id'].to_i).to eq(invoice_item.id)
  end

  it 'can find a invoice_item by passing an unit_price query param' do
    invoice_item = create(:invoice_item, unit_price: "309.49")
    create(:invoice_item, unit_price: "309.49")
    create(:invoice_item, unit_price: "309.49")

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['attributes']['unit_price']).to eq(invoice_item.unit_price.to_s)
    expect(invoice_item_json['data']['id'].to_i).to eq(invoice_item.id)
  end

  it 'can find a invoice_item by passing a created_at query param' do
    invoice_item = create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['id'].to_i).to eq(invoice_item.id)
  end

  it 'can find a invoice_item by passing an updated_at query param' do
    invoice_item = create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data']['id'].to_i).to eq(invoice_item.id)
  end

  #Multi-finders
  it 'can find all invoice_items for a given id' do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(1)
  end

  it 'can find all invoice_items for a given item_id' do
    item_id = create(:item).id
    item_id_2 = create(:item).id
    invoice_item = create(:invoice_item, item_id: item_id)
    create(:invoice_item, item_id: item_id )
    create(:invoice_item, item_id: item_id_2)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item.item_id}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(2)
  end

  it 'can find all invoice_items for a given invoice_id' do
    invoice_id = create(:invoice).id
    invoice_id_2 = create(:invoice).id
    invoice_item = create(:invoice_item, invoice_id: invoice_id)
    create(:invoice_item, invoice_id: invoice_id )
    create(:invoice_item, invoice_id: invoice_id_2)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item.invoice_id}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(2)
  end

  it 'can find all invoice_items for a given quantity' do
    invoice_item = create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 5)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item.quantity}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(3)
  end

  it 'can find all invoice_items for a given unit_price' do
    invoice_item = create(:invoice_item, unit_price: "309.49")
    create(:invoice_item, unit_price: "309.49")
    create(:invoice_item, unit_price: "309.49")

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item.unit_price}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(3)
  end

  it 'can find all invoice_items for a given created_at date' do
    invoice_item_1 = create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')
    create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_1.created_at}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(3)
  end

  it 'can find all invoice_items for a given updated_at date' do
    invoice_item_1 = create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-20')
    create(:invoice_item, created_at: '2019-11-18', updated_at: '2019-11-29')

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item_1.updated_at}"

    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json['data'].count).to eq(2)
  end

  #Random finder
  it 'can return a random resource' do
    get "/api/v1/invoice_items/random"
    invoice_item_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item_json.count).to eq(1)
  end
end
