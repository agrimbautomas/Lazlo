require 'rails_helper'

RSpec.describe CartController, type: :controller do
  include ApplicationHelper

  describe 'GET method' do

    it 'index renders the show cart template' do
      get :show
      expect(response).to render_template('show')
    end

    it 'checkout renders the index template' do
      get :checkout
      expect(response).to render_template('checkout')
    end

  end


  describe 'ApplicationHelper' do
    let(:action) { get :checkout }


  end


end
