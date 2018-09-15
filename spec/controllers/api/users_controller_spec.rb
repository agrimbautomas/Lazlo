require 'rails_helper'
require 'contexts/for_controllers'
require 'shared_examples/for_controllers'

RSpec.shared_context 'send contact form' do
	before {
		post :contact_email, params: {
			:lazlo_name => 'some',
			:lazlo_email => 'some@gmail.com',
			:lazlo_message => 'a message',
			:authenticity_token => rand(999..9999)
		}
	}
end

RSpec.shared_context 'send request to mailchimp' do
	before {
		post :add_to_newsletter, params: { :email => 'some@gmail.com' }
	}
end


RSpec.describe Api::V1::UsersController, type: :controller do
	include ApplicationHelper

	describe 'Send contact form' do

		context 'without Token' do
			include_context 'send contact form'
			include_examples 'expect redirect response'

			it 'should set a flash message' do
				expect(controller).to set_flash[:notice]
			end

			it 'should change the count of sent emails' do
				expect(ActionMailer::Base.deliveries.count).to be >= 1
			end
		end

	end


	describe 'Send new member to mailchimp' do

		context 'without Token' do
			include_context 'send request to mailchimp'
			include_examples 'expect bad request response'
		end

	end

end
