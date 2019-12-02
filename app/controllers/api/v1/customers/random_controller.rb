class Api::V1::CustomersController < ApplicationController
  def show
    random_id = Customer.ids.sample
    render json: CustomerSerializer.new(Customer.find(random_id))
  end
end
