def products

  @sold_products = Placement.sort_by_range(products_params[:start_date], products_params[:end_date], sort_by_params)
  if !products_params[:format].nil?  && products_params[:format] == 'csv'
    # send_data products_as_csv, filename: "tmp/products#{products_params[:start_date]}-#{products_params[:end_date]}.csv"
    send_data products_as_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=#{APP_PATH}/tmp/products#{products_params[:start_date]}-#{products_params[:end_date]}.csv"
  else
    render json: Reports::ProductsSerializer.new(sort_by_params, @sold_products) , status: :ok
  end

end


def products_as_csv
  group_by = @sold_products.keys[0].to_date.as_json
  CSV.generate(headers: true) do |csv|

    csv << %w{sorted_by grouped_by_date name price date_sold qty}

    @sold_products.values.flatten.each do |prod|
      prod = prod.as_json
      csv << [
        sort_by_params,
        group_by,
        prod["name"],
        prod["price"],
        prod["created_at"],
        prod["quantity"]
      ]
    end
  end
end
