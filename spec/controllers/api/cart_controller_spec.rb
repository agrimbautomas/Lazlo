require 'rails_helper'
require 'contexts/for_models'
require 'contexts/for_controllers'
require 'shared_examples/for_controllers'

RSpec.shared_context 'get products in cart' do
  before {get :get_products_in_cart}
end

RSpec.shared_context 'add product to cart' do
  # Should be in json format otherwise displays a view
  before {post :add_product_to_cart, :format => :json,
               params: {:product_id => product.id}
  }
end

RSpec.shared_context 'add product to cart with quantity' do |quantity|
  before {post :add_product_to_cart, :format => :json,
               params: {:product_id => product.id, :quantity => 5 }
  }
end

RSpec.describe Api::V1::CartController, type: :controller do
  include ApplicationHelper

  describe 'Add product to cart' do

    include_context 'create product'

    context 'without Token' do
      include_context 'add product to cart'
      include_examples 'expect unauthorized response'
    end

    context 'with Token' do
      include_context 'create user'
      include_examples 'stub devise'

      context 'POST single product to user cart' do
        include_context 'add product to cart'
        include_examples 'expect successful response'

        it 'should respond success and update the cart' do
          expect(response.body).to match_response_schema('product-cart-response')
        end

        it 'should add a product row to the user checkout list' do
          expect(user.checkout_list.product_rows.count).to eq 1
        end

        it 'should add the product to the user checkout list' do
          expect(user.checkout_list.product_rows.first.product).to eq product
        end

        it 'should add a single product as quantity if not set' do
          expect(user.checkout_list.product_rows.first.quantity).to eq 1
        end

      end

      context 'POST product with quantity to user cart' do
        include_context 'add product to cart with quantity', 5
        include_examples 'expect successful response'

        it 'should respond success and update the cart' do
          expect(response.body).to match_response_schema('product-cart-response')
        end

        it 'should add a product row to the user checkout list' do
          expect(user.checkout_list.product_rows.count).to eq 1
        end

        it 'should match the total of the row with the price per product' do
          expect(user.checkout_list.product_rows.first.total).to eq(product.price * 5)
        end

        it 'should add a single product as quantity if not set' do
          expect(user.checkout_list.product_rows.first.quantity).to eq 5
        end

      end
    end

  end


  describe 'Get product rows' do
    include_context 'create product row'

    context 'with token' do
      include_context 'create user'
      include_examples 'stub devise'

      include_context 'get products in cart'
      include_examples 'expect successful response'
    end
  end

end
