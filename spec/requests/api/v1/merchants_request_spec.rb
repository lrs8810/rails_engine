require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    create_list(:merchant, 3)
  end
  it 'sends a list of merchants' do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(3)
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id'].to_i).to eq(id)
  end

  it 'can find a merchant by passing a name query param' do
    merchant = create(:merchant, name: "Laura's Shop")

    get "/api/v1/merchants/find?name=#{merchant.name}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json['data']['attributes']['name']).to eq(merchant.name)
  end

  it 'can find a merchant by query param regardless name case' do
    merchant = create(:merchant, name: "Laura's Shop")

    get "/api/v1/merchants/find?name=#{merchant.name.upcase}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json['data']['attributes']['name']).to eq(merchant.name)
  end

  it 'can find a merchant by passing an id query param' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json['data']['attributes']['id']).to eq(merchant.id)
  end

  it 'can find a merchant by passing a created_at query param' do
    merchant = Merchant.create!(name: "Laura's Shop", created_at: '2019-11-18', updated_at: '2019-11-29')
    
    get "api/v1/merchants/find?created_at=#{merchant.created_at}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json['data']['id'].to_i).to eq(merchant.id)
  end

  it 'can find a merchant by passing an updated_at query param' do
    merchant = Merchant.create!(name: "Laura's Shop", created_at: '2019-11-18', updated_at: '2019-11-29')

    get "api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    merchant_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_json['data']['id'].to_i).to eq(merchant.id)
  end
end
