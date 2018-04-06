require 'test_helper'

class Api::V1::AuthTest < ActionDispatch::IntegrationTest
  let(:secured_route) { api_secured_path }
  let(:customer) {create(:customer)}
  let(:login) { Hash(auth: Hash(email: customer.email, password: customer.password)) }
  let(:token) { generate_auth_token( customer ) }
  let(:invalid_token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOqJIUzI1NiJ9.ey' }

  it 'creates auth_token' do
    post api_v1_auth_path, params: login
    assert_response :success

    parsed_response.dig('data').tap do |json|
      assert json.key?('jwt')
      assert json.dig('customer').key?('email')
      assert json.dig('customer').key?('id')
      refute json.dig('customer').key?('first_name')
    end
  end

  it 'is authorized with valid token' do
    get secured_route, headers: authenticated_header( token )

    assert_response :success
  end

  it 'is unauthorized without a valid token' do
    get secured_route, headers: authenticated_header( invalid_token )

    assert_response :unauthorized
  end
end
