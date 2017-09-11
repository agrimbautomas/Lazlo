require 'rails_helper'

RSpec.describe Api::V1::CartController, type: :controller do
  include ApplicationHelper

  default_version 1


  let(:product) { create(:product) }

  describe 'CRUD products in user cart' do
	 login_user

	 context 'without Token' do
		before {
		  sign_in nil
		  post :add_product_to_cart, product_id: product.id
		}
		it 'should be redirected if not registered' do
		  expect(response.status).to eq 302
		end
	 end

	 context 'with Token' do

		before do

		end

		context 'POST product to user cart' do
		  before {

		  }

		  it {

			 post :add_product_to_cart,
					:format => :json,
					:product_id => product.id,
					:quantity => 1
			 expect(response.status).to eq 200
			 expect(response.content_type).to eq('application/json')
		  }

		  it 'should respond success and update the cart' do
			 expect(response.body).to match_response_schema('product-cart-response')
		  end

		end
	 end
  end

end
