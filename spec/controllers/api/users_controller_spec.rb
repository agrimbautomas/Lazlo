require 'rails_helper'
require 'contexts/for_controllers'
require 'shared_examples/for_controllers'

RSpec.shared_context 'send request to mailchimp' do
	before {
		post :add_to_newsletter, params: { :email => 'some@gmail.com' }
	}
end


RSpec.describe Api::V1::UsersController, type: :controller do
	include ApplicationHelper


	describe 'Send new member to mailchimp' do

		context 'without Token' do
			include_context 'send request to mailchimp'
			include_examples 'expect bad request response'
		end

	end

end
