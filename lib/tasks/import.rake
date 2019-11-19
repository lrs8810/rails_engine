require 'csv'

desc "Import customers from csv file"
task :import => [:environment] do

  file = "data/customers.csv"

  CSV.foreach(file, :headers => true) do |row|
    Customer.create ({
      :first_name => row[1],
      :last_name => row[2],
      :created_at => row[3],
      :updated_at => row[4]
    })
  end
end
