require 'rails_helper'
require 'shared_examples/for_controllers'

RSpec.shared_context 'get categories response' do
	before { post :dialog_flow_response, {
		params: { queryResult: { action: 'get_categories', parameters: '' } } }
	}
end

RSpec.shared_context 'get category by name response' do
	before { post :dialog_flow_response, {
		params: { queryResult: { action: 'get_category_by_name', parameters: '' } } }
	}
end

RSpec.describe Api::V1::ChatController, type: :controller do
	include ApplicationHelper

	describe 'Get categories for chat responses' do
		let!(:category1) { create(:category) }
		let!(:category2) { create(:category) }

		context 'with params' do
			include_context 'get categories response'

			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end

	describe 'Get category by name' do
		let!(:category1) { create(:category) }

		context 'with params' do
			include_context 'get category by name response'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end

end
