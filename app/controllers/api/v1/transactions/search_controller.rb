class Api::V1::Transactions::SearchController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.order(:id).find_by(request.query_parameters))
  end

  def index
    render json: TransactionSerializer.new(Transaction.where(request.query_parameters).order(:id))
  end
end
