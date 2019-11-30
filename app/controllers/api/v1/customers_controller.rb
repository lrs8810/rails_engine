class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

  def find
    render json: CustomerSerializer.new(Customer.find_by(request.query_parameters))
  end
  #
  # def find_all
  #   render json: MerchantSerializer.new(Merchant.where(request.query_parameters))
  # end
  #
  # def random
  #   random_id = Merchant.ids.sample
  #   render json: MerchantSerializer.new(Merchant.find(random_id))
  # end
end
