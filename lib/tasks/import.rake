require 'csv'

namespace :import do
  desc "Import data from cvs files"
  task customers: :environment do
    customer_file = "data/customers.csv"

    CSV.foreach(customer_file, headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  task merchants: :environment do
    merchant_file = "data/merchants.csv"

    CSV.foreach(merchant_file, headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  task items: :environment do
    item_file = "data/items.csv"

    CSV.foreach(item_file, headers: true) do |row|
      row["unit_price"] = row["unit_price"].to_i/100.0
      Item.create!(row.to_h)
    end
  end

  task invoices: :environment do
    invoice_file = "data/invoices.csv"

    CSV.foreach(invoice_file, headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end

  task transactions: :environment do
    transaction_file = "data/transactions.csv"

    CSV.foreach(transaction_file, headers: true) do |row|

      row[:result] = 0 if row[:result] == "success"
      row[:result] = 1 if row[:result] == "failed"
      Transaction.create!(row.to_h)
    end
  end

  task invoice_items: :environment do
    invoice_item_file = "data/invoice_items.csv"

    CSV.foreach(invoice_item_file, headers: true) do |row|
      row["unit_price"] = row["unit_price"].to_i/100.0
      InvoiceItem.create!(row.to_h)
    end
  end
end
