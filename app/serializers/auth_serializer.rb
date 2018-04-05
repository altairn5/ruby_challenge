class AuthSerializer < ApplicationSerializer
  attr_reader :auth_token, :customer

  def initialize( auth_token, customer, options={} )
    @auth_token  = auth_token
    @customer    = customer
    super( options )
  end

  def data
    Hash(
      jwt: auth_token.token,
      customer: customer.as_json
    )
  end

end
