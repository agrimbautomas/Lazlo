Rails.application.routes.draw do

	mount LetsencryptPlugin::Engine, at: '/'

	begin
		ActiveAdmin.routes(self)
	rescue Exception => e
		puts "ActiveAdmin: #{e.class}: #{e}"
	end

	devise_for :admin_users, ActiveAdmin::Devise.config

	devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }


	root 'home#index'

	resources :categories
	resources :products do
		get 'checkout', to: 'products#purchase'
	end

	get '/cotizador' => 'home#cotizador'

	get '/cart' => 'cart#show', :as => :cart
	get '/me' => 'users#profile', :as => :profile

	get '/cart/checkout' => 'cart#checkout', :as => :cart_checkout

	post '/contact_email' => 'api/v1/api#contact_email'

	get '/tracking/:tracking_code' => 'orders#tracking', :as => :tracking_order_by_code

	# Checkout
	get 'single-checkout-success', to: 'checkout#single_checkout_success'
	get 'single-checkout-pending', to: 'checkout#single_checkout_pending'
	get 'single-checkout-cancelled', to: 'checkout#single_checkout_cancelled'

	get 'cart-checkout-success', to: 'checkout#cart_checkout_success'
	get 'cart-checkout-pending', to: 'checkout#cart_checkout_pending'
	get 'cart-checkout-cancelled', to: 'checkout#cart_checkout_cancelled'

	# API
	scope module: 'api' do
		scope '1', module: 'v1' do
			post 'user/checkout/:product_id', to: 'cart#add_product_to_cart', :as => :add_product_to_cart
			put 'user/checkout_row/:product_row_id', to: 'cart#edit_checkout_product_row', :as => :edit_checkout_row
			delete 'user/cart/:product_id', to: 'cart#remove_cart_product_row', :as => :remove_cart_product_row

			#post 'user/fauvorites/:product_id', to: 'cart#add_product_to_wish_list', :as => :add_product_to_fauvorites
			#delete 'user/cart/:product_id', to: 'cart#remove_product_row', :as => :remove_cart_product

		end
	end

	# error pages
	%w( 404 422 500 503 ).each do |code|
		get code, :to => 'errors#show', :code => code
	end


end
