class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    transactions = Invoice.find(params[:invoice_id]).transactions
    render json: TransactionSerializer.new(transactions)
  end
end
