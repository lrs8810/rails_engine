# Rails Engine
#### Record Endpoints

#### Relationship Endpoints
##### Merchants
``GET /api/v1/merchants/:id/items`` returns a collection of items associated with that merchant<br>
``GET /api/v1/merchants/:id/invoices returns a collection of invoices associated with that merchant from their known orders``
##### Invoices
``GET /api/v1/invoices/:id/transactions returns a collection of associated transactions`` <br>
``GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items``<br>
``GET /api/v1/invoices/:id/items returns a collection of associated items``<br>
``GET /api/v1/invoices/:id/customer returns the associated customer``<br>
``GET /api/v1/invoices/:id/merchant returns the associated merchant``<br>
##### Invoice Items
``GET /api/v1/invoice_items/:id/invoice returns the associated invoice``<br>
``GET /api/v1/invoice_items/:id/item returns the associated item``<br>
##### Items
``GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items``<br>
``GET /api/v1/items/:id/merchant returns the associated merchant``
##### Transactions
``GET /api/v1/transactions/:id/invoice returns the associated invoice``
##### Customers
``GET /api/v1/customers/:id/invoices returns a collection of associated invoices``<br>
``GET /api/v1/customers/:id/transactions returns a collection of associated transactions``

#### Business Intelligence Endpoints
##### All Merchants
``GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue``<br>
``GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants``

##### Single Merchant
``GET /api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most total number of successful transactions.``
