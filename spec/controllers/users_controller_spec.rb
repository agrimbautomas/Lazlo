require 'rails_helper'
require 'shared_examples/for_controllers'
require 'contexts/for_controllers'

RSpec.shared_context 'get user profile' do
	before { get :profile }
end

RSpec.describe UsersController, type: :controller do

	describe 'GET profile for NOT registered Users' do
		include_context 'get user profile'
		include_examples 'expect redirect response'

		it 'index renders the show cart template' do
			expect(response).to redirect_to(new_user_session_path)
		end
	end

	describe 'GET profile for registered Users' do
		include_context 'create user'
		include_examples 'stub devise'

		include_context 'get user profile'
		include_examples 'expect successful view'

		it 'index renders the show cart template' do
			expect(response).to render_template('profile')
		end
	end


end