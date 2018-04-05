module AuthHelper
  #
  # Generate an authentication header
  #
  def authenticated_header(token=nil)
    # binding.pry
    # token ||= generate_auth_token( customer )
    Hash('Authorization': "Bearer #{token}")
  end

  # def headers(format_type="json")
  #   Hash("Content-Type" => "application/#{format_type}")
  # end
  #
  # Login as "Customer"
  #
  def login_as(email, password="123456")
    post api_v1_auth_path, params: Hash(auth: {email: email, password: password})
    assert_response :success

    parsed_response.dig('data', 'jwt')
  end

  def generate_auth_token( customer=Customer.first )
    token = Knock::AuthToken.new(payload: { sub: customer.id }).token
  end

end
