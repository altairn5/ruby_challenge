require 'csv'

class ReportsController < ApplicationController
  before_action :report_params

  def products
    @sold_products = Placement.sort_by_range(products_params[:start_date], products_params[:end_date], sort_by_params)

    render json: Reports::ProductsSerializer.new(sort_by_params, @sold_products) , status: :ok
  end

  private

  def sort_by_params
    products_params.fetch('sort_by', 'day')
  end

  def report_params
    if !params.include?(:start_date)
      render json: {}, status: :ok
    else
      products_params
    end
  end

  def products_params
    params.permit(:start_date, :end_date, :sort_by, :format)
  end

end
