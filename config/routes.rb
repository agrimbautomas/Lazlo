Rails.application.routes.draw do

  mount LetsencryptPlugin::Engine, at: '/' # It must be at root level

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}


  root 'home#index'

  resources :categories
  resources :products do
    get 'purchase-success', to: 'purchase#purchase_success'
    get 'purchase-pending', to: 'purchase#purchase_pending'
    get 'purchase-failure', to: 'purchase#purchase_failure'

    post 'add-to-fauvorites', to: 'users#add_product_to_wish_list'
    get 'purchase-data', to: 'api#purchase_product_data'
    get 'checkout', to: 'products#purchase'
  end

  get '/cotizador' => 'home#cotizador'

  get '/cart' => 'users#cart'

  post '/contact_email' => 'application#contact_email'

  get '/tracking/:tracking_code' => 'orders#tracking', :as => :tracking_order_by_code

  api version: 1, module: 'api/v1' do
    delete 'user/cart/:product_row_id', to: 'cart#remove_product_row', :as => :remove_cart_product
  end

  # error pages
  %w( 404 422 500 503 ).each do |code|
    get code, :to => 'errors#show', :code => code
  end


end
