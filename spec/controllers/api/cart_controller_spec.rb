require 'rails_helper'

RSpec.describe Api::V1::CartController, type: :controller do
  include ApplicationHelper

  default_version 1

  let(:product) {create(:product)}

  describe 'CRUD products in user cart' do

	 context 'POST product to user cart' do
		before {
		  post :add_product_to_cart, product_id: product.id
		}

		it 'should be redirected if not registered' do
		  expect(response.status).to eq 302
		end

		it {
		  expect(response.status).to eq 200
		  expect(response.content_type).to eq('application/json')
		}

		it 'should respond success and update the cart' do
		  sign_in
		  expect(response.body).to match_response_schema('product-cart-response')
		end

	 end
  end
end
