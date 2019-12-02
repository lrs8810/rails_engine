class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.order(:id).find_by(request.query_parameters))
  end

  def index
    render json: ItemSerializer.new(Item.where(request.query_parameters).order(:id))
  end
end
