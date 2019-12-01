class Api::V1::Invoices::CustomerController < ApplicationController
  def index
    customer = Invoice.find(params[:invoice_id]).customer
    render json: CustomerSerializer.new(customer)
  end
end
