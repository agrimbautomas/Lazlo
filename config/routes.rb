Rails.application.routes.draw do

  mount LetsencryptPlugin::Engine, at: '/'  # It must be at root level

  use_doorkeeper
  devise_for :users, skip: [:sessions, :registrations, :passwords],
             :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)


  root 'home#index'

  # Usuarios
  as :user do
    # Passwords
    get 'signup' => 'registrations#new', :as => :new_user_registration
    get 'account/edit' => 'registrations#edit', :as => :edit_user_registration
    post 'signup' => 'registrations#create', :as => :user_registration
    patch 'account/edit' => 'registrations#update'
    put 'account/edit' => 'registrations#update'

    # Sessions
    get 'signin' => 'sessions#new', :as => :new_user_session
    post 'signin' => 'sessions#create', :as => :user_session
    delete 'signout' => 'sessions#destroy', :as => :destroy_user_session

    # Passwords
    get 'user/password/new' => 'devise/passwords#new', :as => :new_user_password
    get 'user/password/edit' => 'devise/passwords#edit', :as => :edit_user_password
    post 'user/password' => 'devise/passwords#create', :as => :user_password
    put 'user/password' => 'devise/passwords#update'
  end

  resources :categories
  resources :products do
    get 'purchased', to: 'products#purchase'
    get 'purchase-data', to: 'api#purchase_product_data'
    get 'checkout', to: 'products#purchase'
  end

  post '/contact_email' => 'home#contact_email'

  get '/tracking/:tracking_code' => 'orders#tracking', :as => :tracking_order_by_code

  get '/cotizador' => 'home#cotizador'




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
