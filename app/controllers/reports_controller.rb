require 'csv'

class ReportsController < ApplicationController
  before_action :ensure_params
  rescue_from ::ActiveRecord::RecordNotFound, with: :missing_params


  def products
    render json: Reports::ProductsSerializer.new(sort_by_params, products_solds) , status: :ok
  end


  def missing_params( error )
    render json: Hash(error: Hash(message: [error.message] ) ), status: :not_found
  end



  private

  def products_solds
    @sold_products ||= Placement.sort_by_range(products_params[:start_date], products_params[:end_date], sort_by_params)
  end

  #
  #
  # Params methods
  #
  #
  def ensure_params
    raise ::ActiveRecord::RecordNotFound, "missing params" unless params.include?(:start_date)
    products_params
  end


  def products_params
    params.permit(:start_date, :end_date, :sort_by)
  end


  def sort_by_params
    @sort_by_params ||= products_params.fetch('sort_by', 'day')
  end

end
