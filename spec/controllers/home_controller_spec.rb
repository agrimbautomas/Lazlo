require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  include ApplicationHelper

  describe 'GET index' do
    it 'assigns @featured_products' do

      featured_products = Product.featured.visible

      get :index
      expect(assigns(:featured_products)).to eq(featured_products)
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
