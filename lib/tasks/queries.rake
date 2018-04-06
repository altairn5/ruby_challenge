require 'csv'

  namespace :customer do

    desc "query returns: customer_id customer_first_name category_id category_name number_purchased"
    task orders_by_category: :environment do

      def run_query
        sql = 'SELECT  cust.id as customer_id, cust.first_name, cat.id as category_id, cat.name as category_name, count(cat.id) as number_purchased
          FROM Customers as cust, Orders as ord, Placements as pl, Categories_products as cp, Categories as cat
          WHERE ord.customer_id = cust.id AND ord.id = pl.order_id AND pl.product_id = cp.product_id AND cp.category_id = cat.id
          GROUP BY cust.id, cust.first_name, cat.id, cat.name'

          ActiveRecord::Base.connection.exec_query(sql)
      end

      result =  run_query

      result.each do |record|
        File.open('tmp/customer_orders_by_category.json', 'a') do |line|
          line.puts record.to_json
        end
      end

      puts result
    end
  end
