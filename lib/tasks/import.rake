require 'csv'

desc "Import customers from csv file"
task :import => [:environment] do

  file = "data/customers.csv"

  CSV.foreach(file, :headers => true) do |row|
    Customer.create!(row.to_h)
  end
end

desc "Import merchants from csv file"
task :import => [:environment] do

  file = "data/merchants.csv"

  CSV.foreach(file, :headers => true) do |row|
    Merchant.create!(row.to_h)
  end
end

desc "Import items from csv file"
task :import => [:environment] do

  file = "data/items.csv"

  CSV.foreach(file, :headers => true) do |row|
    row["unit_price"] = row["unit_price"].to_i/100.0
    Item.create!(row.to_h)
  end
end

desc "Import invoices from csv file"
task :import => [:environment] do

  file = "data/invoices.csv"

  CSV.foreach(file, :headers => true) do |row|
    Invoice.create!(row.to_h)
  end
end

desc "Import invoices from csv file"
task :import => [:environment] do

  file = "data/transactions.csv"

  def change_result(result)
    result == "success"
  end

  CSV.foreach(file, :headers => true) do |row|
    row['result'] = change_result(row['result'])
    Transaction.create!(row.to_h)
  end
end

desc "Import item_invoices from csv file"
task :import => [:environment] do

  file = "data/invoice_items.csv"

  CSV.foreach(file, :headers => true) do |row|
    row["unit_price"] = row["unit_price"].to_i/100.0
    InvoiceItem.create!(row.to_h)
  end
end
