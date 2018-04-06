## SQL QUERY

#### query returns: customer_id customer_first_name category_id category_name number_purchased

Sample:
##### query
```
SELECT  cust.id as customer_id, cust.first_name, cat.id as category_id, cat.name as category_name, count(cat.id) as number_purchased
FROM Customers as cust, Orders as ord, Placements as pl, Categories_products as cp, Categories as cat
WHERE ord.customer_id = cust.id AND ord.id = pl.order_id AND pl.product_id = cp.product_id AND cp.category_id = cat.id
GROUP BY cust.id, cust.first_name, cat.id, cat.name'
```

##### result

```json
{"customer_id":"adb87ab8-557b-41ed-97e8-ef67e71870cc","first_name":"Johnathon","category_id":"1f237bf2-a896-4f2e-b285-bc31def097ad","category_name":"produce","number_purchased":2}
{"customer_id":"a89fd414-a4ac-4816-85ef-675b1d074895","first_name":"Shenika","category_id":"d250cb05-9d48-402d-8cd0-da2cf040b328","category_name":"meat","number_purchased":1}
{"customer_id":"fd033e6b-bee1-40ce-b92d-24523e96cc1a","first_name":"Allegra","category_id":"eb56b4c3-eca0-4b8e-a498-3c7ab3b49324","category_name":"meat","number_purchased":1}
{"customer_id":"a89fd414-a4ac-4816-85ef-675b1d074895","first_name":"Shenika","category_id":"cb5c44f2-973f-45c4-bb57-56c1b0036cc6","category_name":"produce","number_purchased":1}...
```
