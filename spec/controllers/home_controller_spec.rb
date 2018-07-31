require 'rails_helper'
require 'shared_examples/for_controllers'

RSpec.shared_context 'get home view' do
	before { get :index }
end

RSpec.shared_context 'get cotizador view' do
	before { get :cotizador }
end

RSpec.describe HomeController, type: :controller do
	include ApplicationHelper

	describe 'GET Home page' do
		include_context 'get home view'
		include_examples 'expect successful view'
	end

	describe 'GET index' do
		include_context 'get home view'
		it 'assigns @most_liked_product' do
			most_liked_product = Product.most_viewed
			expect(assigns(:most_liked_product)).to eq(most_liked_product)
		end

		it 'renders the index template' do
			expect(response).to render_template('index')
		end
		
		it 'should check if mobile' do
			expect(mobile_device?).to eq(nil)
		end

	end

	describe 'When displays cotizador view' do
		include_context 'get cotizador view'
		it 'renders the cotizator template' do
			expect(response).to render_template('home/cotizador')
		end
	end


end