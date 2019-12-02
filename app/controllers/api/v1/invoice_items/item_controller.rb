class Api::V1::InvoiceItems::ItemController < ApplicationController
  def index
    item = InvoiceItem.find(params[:invoice_item_id]).item
    render json: ItemSerializer.new(item)
  end
end
