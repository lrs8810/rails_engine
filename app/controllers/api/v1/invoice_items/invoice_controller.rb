class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def index
    invoice = InvoiceItem.find(params[:invoice_item_id]).invoice
    render json: InvoiceSerializer.new(invoice)
  end
end
