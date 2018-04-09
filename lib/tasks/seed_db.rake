require 'factory_bot'

  namespace :db do

    desc "query returns: customer_id customer_first_name category_id category_name number_purchased"
    task seed_data: :environment do
      include FactoryBot::Syntax::Methods

      def seed_loader
        create_orders
      end

      def create_orders
        cust_1 =  create(:customer)
        cust_2 =  create(:customer)
        cust_3 =  create(:customer)

        product_list_1 = create_list(:product, 10, :multiple_categories)
        product_list_2 = create_list(:product, 5, :multiple_categories)
        product_list_3 = create_list(:product, 3)

        order_1 = build(:order, customer: cust_1)
        order_2 = create(:order, products: product_list_2, customer: cust_2)
        order_3 = create(:order, products: product_list_3, customer: cust_3)

        prods_and_quantities = product_list_1.map{ |prod| [prod.id, rand(2..10)] }
        order_1.multiple_quantities(prods_and_quantities)
        order_1.save!
      end

      seed_loader
    end
  end
