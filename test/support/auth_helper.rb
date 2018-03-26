module AuthHelper
  #
  # Generate an authentication header
  #
  def authenticated_header(customer=Customer.first)
    token = Knock::AuthToken.new(payload: { sub: customer.id }).token

    Hash('Authorization': "Bearer #{token}")
  end

  #
  # Login as "user"
  #
  def login_as(email, password="123456")
    post api_v1_auth_path, params: Hash(auth: {email: email, password: password})
    assert_response :success

    parsed_response.dig('data', 'jwt')
  end
end
