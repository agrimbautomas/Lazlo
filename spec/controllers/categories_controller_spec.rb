require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include ApplicationHelper

  let!(:category) { create(:category) }

  describe 'GET categorie products ' do

	 before {
		get :show, :id => category.slug
	 }

	 it { expect(response.status).to eq 200 }
	 it { expect(response.content_type).to eq('text/html') }

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
