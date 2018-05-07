require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  include ApplicationHelper

  describe 'GET index' do
    it 'assigns @most_liked_product' do
		most_liked_product = Product.most_viewed
      get :index
      expect(assigns(:most_liked_product)).to eq(most_liked_product)
	 end

    it 'assigns @home_page with page values' do
		home_page =Page.find_by_name 'Home'
      get :index
      expect(assigns(:home_page)).to eq(home_page)
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
