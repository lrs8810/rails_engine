class Api::V1::Invoices::MerchantController < ApplicationController
  def index
    merchant = Invoice.find(params[:invoice_id]).merchant
    render json: MerchantSerializer.new(merchant)
  end
end
