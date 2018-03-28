Rails.application.routes.draw do
  post 'api/v1/auth/customer_token' => 'api/v1/auth/customer_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #
      # Auth routes
      #
      post '/auth/token' => 'auth/customer_token#create', as: :auth

      #
      # Customers routes
      #

      #
      # All Products routes
      #

      get '/products', to: 'products#index', as: :products

      #
      # Orders for customer
      #
      get '/customers/:customer_id/orders', to: 'orders#index', as: :orders

    end
    # root secured path, ie: /api
    root to: 'secured#index', as: :secured

    # catch all missing api routes
    match '*path', action: 'route_not_found', via: :all
  end
end
