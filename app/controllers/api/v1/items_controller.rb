class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
  #
  # def find
  #   render json: CustomerSerializer.new(Customer.find_by(request.query_parameters))
  # end
  #
  # def find_all
  #   render json: CustomerSerializer.new(Customer.where(request.query_parameters))
  # end
  #
  # def random
  #   random_id = Customer.ids.sample
  #   render json: CustomerSerializer.new(Customer.find(random_id))
  # end
end
