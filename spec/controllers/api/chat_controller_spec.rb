require 'rails_helper'
require 'shared_examples/for_controllers'

RSpec.shared_context 'get chat response' do |action|
	before { post :dialog_flow_response, {
		params: { queryResult: { action: action, parameters: nil } } }
	}
end

RSpec.shared_context 'get category by name' do |action|
	before { post :dialog_flow_response, {
		params: { queryResult: { action: action, parameters: {product_category: category1.name} } } }
	}
end

RSpec.shared_context 'get marvel by name' do |action|
	before { post :dialog_flow_response, {
		params: { queryResult: { action: action, parameters: {product_category: marvel.name} } } }
	}
end

RSpec.describe Api::V1::ChatController, type: :controller do
	include ApplicationHelper
	let(:category1) { create(:category) }
	let(:category2) { create(:category) }

	let(:marvel) { create(:marvel) }

	describe 'Get categories for chat responses' do

		context 'with params' do
			include_context 'get chat response', 'get_categories'

			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end

	describe 'Get category by name' do
		context 'with empty params' do
			include_context 'get category by name', 'get_category_by_name', nil

			include_examples 'expect bad request response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

		context 'with params' do
			include_context 'get category by name', 'get_category_by_name'
			include_examples 'expect successful response'


			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end


	describe 'Get marvels for chat responses' do

		context 'with params' do
			include_context 'get chat response', 'get_marvels'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end

	describe 'Get marvel by name' do
		context 'with empty params' do
			include_context 'get marvel by name', 'get_marvel_by_name'
			include_examples 'expect bad request response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

		context 'with params' do

			include_context 'get marvel by name', 'get_marvel_by_name'
			include_examples 'expect successful response'


			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end
end
