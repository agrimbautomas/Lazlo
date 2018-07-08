require 'rails_helper'
require 'shared_examples/for_controllers'

RSpec.describe HomeController, type: :controller do
	include ApplicationHelper

	describe 'GET Home page' do
		context 'without params' do
			include_examples 'expect successful view response'
		end
	end

	describe 'GET index' do
		it 'assigns @most_liked_product' do
			most_liked_product = Product.most_viewed
			get :index
			expect(assigns(:most_liked_product)).to eq(most_liked_product)
		end

		it 'renders the index template' do
			get :index
			expect(response).to render_template('index')
		end

		it 'renders the cotizator template' do
			get :cotizador
			expect(response).to render_template('home/cotizador')
		end
	end


	describe 'ApplicationHelper' do
		let(:action) { get :index }

		it 'should check if mobile' do
			expect(mobile_device?).to eq(nil)
		end

	end

end