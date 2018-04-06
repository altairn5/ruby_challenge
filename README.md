# Shipt API

### Dependencies

- Ruby v.2.3.1
- Rails v.5.1.5
- Bundler v.1.16.0
- Rake v.12.3.1
- PostgreSQL v.9.1 and up

### Running project locally:

1. Download project
2. Run Bundle install
3. Run the following commands:
    - Rake db:create
    - Rake db:migrate
    - Rake db:test:prepare
    - Rake db:test (Test should pass before continuing)
4. Seed development database with mock data by running the following rake task, located in  [/lib/tasks/seed_db.rake](./lib/tasks/seed_db.rake)

	###### Rake task:
    - `rake db:seed_data`
5. Run server locally `rails s` | `rails server` (http://localhost:3000/)

## API endpoints (See more info below)

### Login
`POST /api/v1/auth/token`
### Reports
 `GET /api/reports/products`
### Orders
 `GET /api/v1/customers/:customer_id/orders`

### Project Requirements

#### 1. Please implement the following stories.
   - A product belongs to many categories. A category has many products. A product can be sold in decimal amounts (such as weights).
   - A customer can have many orders. An order is comprised of many products. An order has a status stating if the order is waiting for delivery, on its way, or delivered.

####  2. Write a SQL query to return the results as display below:
#####  Example
`customer_id customer_first_name category_id category_name number_purchased => 1 John 1 Bouquets 15`

  - SQL query can be found in file [docs/queries.md](./docs/queries.md)

#### 3. Include the previous result as part of a function in the application. If you are using an ORM, please write the query in your ORM's DSL. Leave the original SQL in a separate file.

  The rake task below, can be found in [/lib/tasks/queries.rake](./lib/tasks/queries.rake). Results will be printed in the terminal and also exported to file,
	`tmp/customer_orders_by_category.json`


	###### Rake task:

  - `rake customer:orders_by_category`

#### 4. An API endpoint that accepts a date range and a day, week, or month and returns a breakdown of products sold by quantity per day/week/month.

   ##### Example:

   ###### Reports (products) endpoint:
     `GET reports/products?start_date=<yyyy-mm-dd>&end_date=<yyyy-mm-dd>&sort_by=<day_week_or_month>`

  * Note: if `sort_by` is omitted, it defaults to `day`

  ###### Curl Request:

	```
	curl -X GET \
	  'http://localhost:3000/reports/products?start_date=2018-04-01&end_date=2018-04-06&sort_by=week' \
	  -H 'Cache-Control: no-cache' \
	```

	  ###### Response:
	```
	{
	    "data": {
	        "items_sold": 78,
	        "sorted_by": "week",
	        "products": {
	            "2018-04-02": [
	                {
	                    "name": "Digital Auto Bracket",
	                    "price": "17.79",
	                    "created_at": "2018-04-06T03:52:30.110Z",
	                    "quantity": 1
	                },
	                {
	                    "name": "Digital Auto Bracket",
	                    "price": "46.85",
	                    "created_at": "2018-04-06T03:52:30.126Z",
	                    "quantity": 1
	                },
	                {
	                    "name": "Digital Auto Bracket",
	                    "price": "6.32",
	                    "created_at": "2018-04-06T03:52:30.142Z",
	                    "quantity": 1
	                }...
	```

#### 6. Ability to export the results of #5 to CSV.
  - The rake task below is located [/lib/tasks/reports.rake](./lib/tasks/reports.rake). Results will be exported to file,`tmp/products_sold_<yyyy-mm-dd>_<yyyy-mm-dd>.csv`

	Ex.
	`tmp/products_sold_2018-04-04_2018-04-06.csv`

	###### Rake task:
  `rake reports:products`

#### 7. An API endpoint that returns the orders for a customer.

  - The customer's orders (`/api/v1/customers/:customer_id/orders`) endpoints required a JSON Web Token (JWT). In order to obtain a JWT follow the steps below

  ##### Note: For the following steps, it is assumed that the development db was seeded with mock data (Please see steps above).

  a. Run `rails console` and find any customer's email and address and use "1234555" as password.
  b. make a Post curl request to obtain a JWT to endpoint, `/api/v1/auth/token`

##### Request:
```
curl -X POST \
 http://localhost:3000/api/v1/auth/token \
 -H 'Accept: application/json' \
 -H 'Cache-Control: no-cache' \
 -H 'Content-Type: application/json' \
 -d '{
	"auth": {
 		"email": "nelly@stantonmurazik.name",
		"password": "1234555"
 	 	}
	 }'
 ```

##### Response:
  ```
  {
    "data": {
        "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjMxNDY3NTMsImF1ZCI6bnVsbCwic3ViIjoiYTg5ZmQ0MTQtYTRhYy00ODE2LTg1ZWYtNjc1YjFkMDc0ODk1In0.1kVv87IWbSuvCx_Zk2WLcOLnUQuXj8kR_a-hPnmQGdk",
        "customer": {
            "id": "a89fd414-a4ac-4816-85ef-675b1d074895",
            "email": "nelly@stantonmurazik.name"
        }
    }
}
```

c. use customer_id and jwt for calls to  `api/v1/customers/:customer_id/orders` endpoint

##### Request:

```
curl -X GET \
  http://localhost:3000/api/v1/customers/207bd469-146a-4bdb-9e9a-f8f1e05a70f9/orders \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjMxNTk1OTMsImF1ZCI6bnVsbCwic3ViIjoiMjA3YmQ0NjktMTQ2YS00YmRiLTllOWEtZjhmMWUwNWE3MGY5In0.O5Oau6uaNWXNVM6kF-a_7Ey9vyl1IGWBh25No7wZuBE' \
  -H 'Cache-Control: no-cache' \
```

##### Response:
```
    "data": {
        "order_count": 1,
        "orders": [
            {
                "total": "88.73",
                "status": "pending",
                "products": [
                    {
                        "name": "Digital Auto Bracket",
                        "price": "17.79"
                    },
                    {
                        "name": "Digital Auto Bracket",
                        "price": "46.85"
                    },
                    {
                        "name": "Digital Auto Bracket",
                        "price": "6.32"
                    },
                    {
                        "name": "Digital Auto Bracket",
                        "price": "3.34"
                    },
                    {
                        "name": "Digital Auto Bracket",
                        "price": "14.43"
                    }
                ]
            }
        ]
    }
}
```

#### Additional

No coding necessary, explain the concept or sketch your thoughts.

### 8. **Question:**
We want to give customers the ability to create lists of products for a one-click ordering of bulk items. How would you design the tables, what are the pros and cons of your approach?

**Answer:**
(A supporting diagram is located in the project root titled: shipt_ERD.pdf)   I would create a new table called Item_list which would essentially have the same associations as Order: it would belong to Customer and have a has_and_belongs_to_many relationship with products.   When a customer wants to purchase their Item_list, a method would be invoked which would take each of the products associated with a given Item_list and create a new Order record with those same items.  The benefits of this approach are separation of entities.  Item_list and Orders are separate entities, even though an item_list can inform an Order

### 9. **Question:**
If Shipt knew the exact inventory of stores, and when facing a high traffic and limited supply of a particular item, how do you distribute the inventory among customers checking out?

**Answer:**
Since we know exactly what the inventory is of an item, I would set a flag to be raised when total supply of an item reaches a certain lower limit.  If a customer adds that item to their current shopping cart, a message should be displayed which notifies the customer that supply for that item is low (possibly displaying how many of the item are left) and will be reserved for them during a period of time (possibly five minutes?).  A decrementing timer should be displayed, costing down the time the customer has until the hold on that item has expired.  This operation should preferably not take place on the server, but rather in the database.  This is because it is advised not to keep any sort of state in on the server, in case of faults.  


# To RUN Locally
## System dependencies
You will need to have ruby 2.4.1, Postgres Rails 5.1 installed on your machine.  Once that is done, download the file and run the command `bundle install` to install all necessary gems

## Database creation
First ensure Postgres is running.  Then run the commands: rake db:create db:migrate db:seed to create, initialize and seed the DB

## How to run the test suite
You can run the test suite with the rspec command.  Unfortunately only the models have test coverage... with more time I would write tests for the serializer, controllers and two rake tasks.

## Server
Run the command `rails s` and the root app will default to `http://localhost:3000/`

## Rake Tasks
In namespace `query` I have two rake tasks
1. customer_categories_purchased
2. products_sold_csv

## API endpoints
There are two endpoints:
1. GET '/product'
2. GET '/customer/:id/orders'

## A few conscious choices and things to improve:
* I replaced the active_record ids with UUIDs to reduce the likleyhood of eventual duplication.

* Test coverage is weak, with only the models being fully covered.  Next steps would be to strengthen that by writing more tests.

* In ProductsSoldByIntervalSerializer, the by_week and by_month methods are using nested loop structures which are costly in terms of Auxiliary Time used, O(N^2).  Ideally I would like to refactor those methods to something with a maximum auxiliary time of O(N).
