class Api::SecuredController < ApplicationController
  before_action :authenticate_customer

  def index
    render json: 'secured'
  end

end
