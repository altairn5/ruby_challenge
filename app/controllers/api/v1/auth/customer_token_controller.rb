class Api::V1::Auth::CustomerTokenController < Knock::AuthTokenController
  #
  #
  #
  def create
    render json: ::AuthSerializer.new( auth_token, entity ), status: :created
  end

  private

  def entity_class
    ::Customer
  end
end
