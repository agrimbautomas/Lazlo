require 'rails_helper'

RSpec.describe Api::V1::CartController, type: :controller do
  include ApplicationHelper

  default_version 1

  let(:user) {create(:user)}
  let(:product) {create(:product)}
  let(:token) {double :acceptable? => true, :scopes => [:user]}

  describe 'CRUD products in user cart' do

	 context 'without Token' do
		before {post :add_product_to_cart, product_id: product.id}
		it 'should be redirected if not registered' do
		  expect(response.status).to eq 302
		end
	 end

	 context 'with Token' do

		before do
		  allow(controller).to receive(:doorkeeper_token) {token}
		  allow(controller).to receive(:current_user) {user}
		end

		context 'POST product to user cart' do
		  before {
			 post :add_product_to_cart, product_id: product.id
		  }
		  z 
		  it {
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
