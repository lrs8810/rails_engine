class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices


  def self.most_revenue(limit = 5)
    joins(:invoice_items, :transactions)
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .group(:id)
    .merge(Transaction.successful)
    .order("total_revenue desc")
    .limit(limit)
  end
end
