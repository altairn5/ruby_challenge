require 'test_helper'

class Api::V1::AuthTest < ActionDispatch::IntegrationTest
  let(:secured_route) { api_secured_path }
  let(:customer) {create(:customer)}
  let(:login) { Hash(auth: Hash(email: customer.email, password: customer.password)) }
  let(:invalid_token) { "eyJ0eXAiOiJKV1QiLCJhbGciOqJIUzI1NiJ9.eyJleHAiOjE1MjIzNjExNzgsImF1ZCI6bnVsbCwic3ViIjoiYjZhNzBmOTktZDA3Ny01ZGUxLTg1MjItNzI1Y2VkMGZkZmJiIn0.Ws8ubXSQB69Rn7d8AKVoUkgZAB9HMY3xE2H-sxRuS2U" }

  #clean up
  it 'creates auth_token' do
    post api_v1_auth_path, params: login
    assert_response :success

    parsed_response.dig('data').tap do |json|
      assert json.dig('jwt').present?
      assert json.dig('customer').present?
    end
  end

  it 'is authorized with valid token' do
    token = generate_auth_token( customer )
    get secured_route, headers: authenticated_header( token )
    assert_response :success
  end

  it 'is unauthorized without a valid token' do
    get secured_route, headers: authenticated_header( invalid_token )
    assert_response :unauthorized
  end
end
