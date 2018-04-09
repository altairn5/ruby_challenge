### E-commerce API Exercise

### Dependencies

- Ruby v.2.3.1
- Rails v.5.1.5
- Bundler v.1.16.0
- Rake v.12.3.1
- PostgreSQL v.9.1 and up

### Running project locally:

1. Download project
2. Run Bundle install
3. Start Postgres
3. Run the following commands:
    - Rake db:create
    - Rake db:migrate
    - Rake db:test:prepare
    - Rake db:test (All test should pass)

4. In order to test different tasks, the development database needs to be seeded with mock data. Run the following rake task located in  [/lib/tasks/seed_db.rake](./lib/tasks/seed_db.rake)

	###### Rake task:
    - `rake db:seed_data`
5. Run server locally `rails s` | `rails server` (http://localhost:3000/)

## API endpoints (See detailed information below)

### Login
`POST /api/v1/auth/token`
### Reports
 `GET /api/reports/products`
### Orders
 `GET /api/v1/customers/:customer_id/orders`


#### Final thoughts:
* I really enjoying putting to practice my RESTful API knowledge to build an ecommerce API
with more time and in addition to adding functionality beyond the scope of this challenge, I would have worked
on building more robust test, error handling processes, serializers.
