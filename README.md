# Rails Engine
Rails Engine was a week 1, solo-project utilizing Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema. 

## Ruby and Rails Version
````
Ruby 2.4.1
Rails 5.2.3
````

## Installation 
To use this repository, clone the repo onto your local machine by running the following commands in your terminal: 
````
git clone https://github.com/lrs8810/rails_engine
cd rails_engine
bundle
````

## Usage
Run the tests with RSpec: 
````
rspec
````
Run Rails Engine against the Spec Harness: 
````
rake
````

## API Endpoints
#### Record Endpoints
``GET /api/v1/merchants/index``<br>
``GET /api/v1/merchants/show``<br>
``GET /api/v1/merchants/find?name=``<br>
``GET /api/v1/merchants/find_all?name=``<br>
``GET /api/v1/merchants/random``

#### Relationship Endpoints
##### Merchants
``GET /api/v1/merchants/:id/items`` returns a collection of items associated with that merchant<br>
``GET /api/v1/merchants/:id/invoices`` returns a collection of invoices associated with that merchant from their known orders
##### Invoices
``GET /api/v1/invoices/:id/transactions`` returns a collection of associated transactions <br>
``GET /api/v1/invoices/:id/invoice_items`` returns a collection of associated invoice items<br>
``GET /api/v1/invoices/:id/items`` returns a collection of associated items<br>
``GET /api/v1/invoices/:id/customer`` returns the associated customer<br>
``GET /api/v1/invoices/:id/merchant`` returns the associated merchant<br>
##### Invoice Items
``GET /api/v1/invoice_items/:id/invoice`` returns the associated invoice<br>
``GET /api/v1/invoice_items/:id/item`` returns the associated item<br>
##### Items
``GET /api/v1/items/:id/invoice_items`` returns a collection of associated invoice items<br>
``GET /api/v1/items/:id/merchant`` returns the associated merchant
##### Transactions
``GET /api/v1/transactions/:id/invoice`` returns the associated invoice
##### Customers
``GET /api/v1/customers/:id/invoices`` returns a collection of associated invoices<br>
``GET /api/v1/customers/:id/transactions`` returns a collection of associated transactions

#### Business Intelligence Endpoints
##### All Merchants
``GET /api/v1/merchants/most_revenue?quantity=x`` returns the top x merchants ranked by total revenue<br>
``GET /api/v1/merchants/revenue?date=x`` returns the total revenue for date x across all merchants

##### Single Merchant
``GET /api/v1/merchants/:id/favorite_customer`` returns the customer who has conducted the most total number of successful transactions.
