class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.order(:id).find_by(request.query_parameters))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(request.query_parameters).order(:id))
  end
end
