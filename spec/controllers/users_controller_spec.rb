require 'rails_helper'


RSpec.describe UsersController, type: :controller do

	describe 'GET profile for NOT registered Users' do
		it 'index renders the show cart template' do
			get :profile
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	describe 'GET profile for registered Users' do
		login_user

		it 'index renders the show cart template' do
			get :profile
			expect(response).to render_template('profile')
		end
	end

end