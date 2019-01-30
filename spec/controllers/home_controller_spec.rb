require 'rails_helper'
require 'shared_examples/for_controllers'

RSpec.shared_context 'get home view' do
	before { get :index }
end

RSpec.describe HomeController, type: :controller do
	include ApplicationHelper

	let(:product) { create :product }
	let!(:site_config) { SiteConfig.create!(caption: 'A caption', config_type: :most_liked_product, product: product) }

	describe 'GET Home page' do
		include_context 'get home view'
		include_examples 'expect successful view'
	end

	describe 'GET index' do
		include_context 'get home view'
		it 'assigns @most_purchased_product_product' do
			most_purchased_product = Product.most_viewed
			expect(assigns(:most_purchased_product)).to eq(most_purchased_product)
		end

		it 'assigns @@most_liked_product_product_product' do
			most_liked_product = SiteConfig.most_liked_product.first.product
			expect(assigns(:most_liked_product)).to eq(most_liked_product)
		end

		it 'renders the index template' do
			expect(response).to render_template('index')
		end

		it 'should check if mobile' do
			expect(mobile_device?).to eq(nil)
		end

	end

end