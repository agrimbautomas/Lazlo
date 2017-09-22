require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include ApplicationHelper

  let!(:product) { create(:product) }

  describe 'GET product for NOT registered user' do

	 before {
		get :show, :id => product.slug
	 }

	 it { expect(response.status).to eq 200 }
	 it { expect(response.content_type).to eq('text/html') }

	 it 'renders the product template' do
		expect(response).to render_template('show')
	 end


  end

  describe 'GET product for registered user' do
	 login_user

	 before {
		get :show, :id => product.slug
	 }

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
