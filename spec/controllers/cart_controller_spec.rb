require 'rails_helper'

RSpec.describe CartController, type: :controller do
  include ApplicationHelper

  describe 'GET method' do

	 it 'index renders the show cart template' do
		sign_in
		get :show
		expect(response).to render_template('show')
	 end

	 it 'index renders the show cart template' do
		sign_in nil
		get :show
		expect(response).to redirect_to(new_user_session_path)

	 end

  end


  describe 'ApplicationHelper' do
	 let(:action) {get :checkout}
  end

end