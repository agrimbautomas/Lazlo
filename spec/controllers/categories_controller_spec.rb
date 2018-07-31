require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
	include ApplicationHelper

	let!(:category) { create(:category) }

	describe 'GET categorie products ' do

		before {
			get :show, params: { :id => category.slug }
		}

		include_examples 'expect successful view'

		it 'renders the product template' do
			expect(response).to render_template('show')
		end


		it 'assigns @category to the category' do
			expect(assigns(:category)).to be_a(Category)
		end

		it 'assigns @products' do
			expect(assigns(:products)).to all(be_a(Product))
		end

	end


end
