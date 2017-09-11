require 'rails_helper'

RSpec.describe CartController, type: :controller do
  include ApplicationHelper


  describe 'GET cart for not registered user' do
	 it 'index renders the show cart template' do
		get :show
		expect(response).to redirect_to(new_user_session_path)

	 end
  end

  describe 'GET method for registered user' do
	 login_user

	 it 'index renders the show cart template' do
		get :show
		expect(response).to render_template('show')
	 end
  end

  describe 'ApplicationHelper' do
	 let(:action) { get :checkout }
  end

end