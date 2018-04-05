require 'csv'

  namespace :customer do

    desc "query returns: customer_id customer_first_name category_id category_name number_purchased"
    task orders_by_category: :environment do

      def run_query
        sql = 'SELECT  c.id as customer_id, c.first_name, ca.id as category_id, ca.name as category_name, count(ca.id) as number_purchased
          FROM Customers as c, Orders as o, Placements as pl, Categories_products as cp, Categories as ca
          WHERE o.customer_id = c.id AND o.id = pl.order_id AND pl.product_id = cp.product_id AND cp.category_id = ca.id
          GROUP BY c.id, c.first_name, ca.id, ca.name'

          ActiveRecord::Base.connection.exec_query(sql)
      end

      result =  run_query

      result.each do |record|
        File.open("customer_orders_by_category.json", "a") do |line|
          line.puts record.to_json
        end
      end

      puts result
    end
  end
