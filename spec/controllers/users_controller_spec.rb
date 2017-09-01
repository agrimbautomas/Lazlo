require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include ApplicationHelper

  describe 'GET method' do

	 it 'index renders the show cart template' do
		sign_in
		get :profile
		expect(response).to render_template('profile')
	 end

	 it 'index renders the show cart template' do
		sign_in nil
		get :profile
		expect(response).to redirect_to(new_user_session_path)

	 end

  end

end