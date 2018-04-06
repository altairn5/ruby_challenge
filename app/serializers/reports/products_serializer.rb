class Reports::ProductsSerializer < ApplicationSerializer
  attr_reader :sort_by_params, :products

  def initialize( sort_by_params, products, options={})
    @sort_by_params = sort_by_params
    @products = products

    super(options)
  end

  def data
    Hash(
      items_sold: get_total_count,
      sorted_by: sort_by_params,
      products: serialize_products
    )
  end

  #
  #
  # serializer methods
  #
  #
  def serialize_products
    prods = {}

    products.each do |period, items|
      prods[period.to_date] = items.map do |prod|
        prod.as_json(except: ["id", "updated_at"])
      end
    end

    prods
  end


  def get_total_count
    count = 0

    products.values.flatten.each do |prod|
      count += prod[:quantity]
    end

    count
  end


  def as_csv
    CSV.generate(headers: true) do |csv|

      csv << %w{sorted_by grouped_by_date name price date_sold qty}

      products.each do |period, items|
        group_by = period.to_date.as_json

        items.each do |prod|
          prod = prod.as_json
          csv << [
            sort_by_params,
            group_by,
            prod["name"],
            prod["price"],
            prod["created_at"].to_date.as_json,
            prod["quantity"]
          ]
        end
      end
    end
  end

end
