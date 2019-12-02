class Api::V1::Transactions::InvoiceController < ApplicationController
  def index
    invoice = Transaction.find(params[:transaction_id]).invoice
    render json: InvoiceSerializer.new(invoice)
  end
end
