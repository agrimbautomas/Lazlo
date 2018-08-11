require 'rails_helper'
require 'shared_examples/for_controllers'
require 'contexts/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'get product by slug' do
	before { get :show, params: { :id => product.slug } }
end


RSpec.describe ProductsController, type: :controller do
	include ApplicationHelper

	include_context 'create product'

	describe 'GET product for NOT registered user' do
		include_context 'get product by slug'
		include_examples 'expect successful view'

		it 'renders the product template' do
			expect(response).to render_template('show')
		end

		it 'assigns @current_section' do
			expect(assigns(:current_section)).to eq 'products'
		end

	end

	describe 'GET product for registered user' do
		include_context 'create user'
		include_examples 'stub devise'

		include_context 'get product by slug'

		it 'assigns @is_in_cart' do
			expect(assigns(:is_in_cart)).to be(false)
		end

		it 'assigns @product_link' do
			expect(assigns(:product_link)).to match('/sandbox.mercadopago.com/')
		end

		it 'should have @product_hash assigned' do
			expect(assigns(:product_hash)).to be_a(Hash)
		end

		it 'should have the key product_id' do
			expect(assigns(:product_hash)).to have_key(:product_id)
		end

		it 'should have the key version' do
			expect(assigns(:product_hash)).to have_key(:version)
		end


	end


end
