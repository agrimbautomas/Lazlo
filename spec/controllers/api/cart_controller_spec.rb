require 'rails_helper'

RSpec.describe Api::V1::CartController, type: :controller do
	include ApplicationHelper

	let(:product) { create(:product) }

	describe 'CRUD products in user cart' do

		context 'without Token' do
			before { post :add_product_to_cart, params: { product_id: product.id } }
			it 'should be redirected if not registered' do
				expect(response.status).to eq 302
			end
		end

		context 'with Token' do

			before do

			end

			context 'POST product to user cart' do
				login_user

				before {
					post :add_product_to_cart,
						:format => :json,
						params: {
							:product_id => product.id,
							:quantity => 1
						}
				}

				it { expect(response.status).to eq 200 }
				it { expect(response.content_type).to eq('application/json') }

				it 'should respond success and update the cart' do
					expect(response.body).to match_response_schema('product-cart-response')
				end

			end
		end
	end

end
