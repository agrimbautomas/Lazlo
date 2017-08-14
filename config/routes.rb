Rails.application.routes.draw do

  mount LetsencryptPlugin::Engine, at: '/' # It must be at root level

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}


  root 'home#index'

  resources :categories
  resources :products do
	 get 'single-purchase-success', to: 'purchase#single_purchase_success'
	 get 'single-purchase-pending', to: 'purchase#single_purchase_pending'
	 get 'single-purchase-failure', to: 'purchase#single_purchase_failure'

	 get 'cart-purchase-success', to: 'purchase#cart_purchase_success'
	 get 'cart-purchase-pending', to: 'purchase#cart_purchase_pending'
	 get 'cart-purchase-failure', to: 'purchase#cart_purchase_failure'

	 get 'checkout', to: 'products#purchase'
  end

  get '/cotizador' => 'home#cotizador'

  get '/cart' => 'cart#show', :as => :cart
  get '/me' => 'users#profile', :as => :profile

  get '/cart/checkout' => 'cart#checkout', :as => :cart_checkout

  post '/contact_email' => 'application#contact_email'

  get '/tracking/:tracking_code' => 'orders#tracking', :as => :tracking_order_by_code

  api version: 1, module: 'api/v1' do
	 post 'user/checkout/:product_id', to: 'cart#add_product_to_cart', :as => :add_product_to_cart
	 put 'user/checkout_row/:product_row_id', to: 'cart#edit_checkout_product_row', :as => :edit_checkout_row
	 delete 'user/cart/:product_id', to: 'cart#remove_cart_product_row', :as => :remove_cart_product_row

	 #post 'user/fauvorites/:product_id', to: 'cart#add_product_to_wish_list', :as => :add_product_to_fauvorites
	 #delete 'user/cart/:product_id', to: 'cart#remove_product_row', :as => :remove_cart_product
  end

  # error pages
  %w( 404 422 500 503 ).each do |code|
	 get code, :to => 'errors#show', :code => code
  end


end
