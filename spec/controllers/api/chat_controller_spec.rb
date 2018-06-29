require 'rails_helper'
require 'shared_examples/for_controllers'

RSpec.shared_context 'get chat response' do |action|
	before { post :dialog_flow_response, {
			params: { queryResult: { action: action, parameters: nil } } }
	}
end

RSpec.shared_context 'get category by name' do |action|
	before { post :dialog_flow_response, {
			params: { queryResult: { action: action, parameters: { product_category: category_name } } } }
	}
end

RSpec.shared_context 'get materials by name' do |action|
	before { post :dialog_flow_response, {
			params: { queryResult: { action: action, parameters: { material: [material_name] } } } }
	}
end

RSpec.shared_context 'get products by name' do |action|
	before { post :dialog_flow_response, {
			params: { queryResult: { action: action, parameters: { product: [product_name] } } } }
	}
end

RSpec.shared_context 'get budget by material' do |action|
	before { post :dialog_flow_response, {
			params: { queryResult: { action: action, parameters: {
					material: material_name,
					product_size: '120x130x45'
			} } } }
	}
end

RSpec.describe Api::V1::ChatController, type: :controller do
	include ApplicationHelper
	let(:category_name) { nil }
	let(:material_name) { nil }
	let(:product_name) { nil }

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
			include_context 'get category by name', 'get_category_by_name'
			include_examples 'expect bad request response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end
		end

		context 'with params' do
			let(:a_category) { create(:category) }
			let(:category_name) { a_category.name }
			include_context 'get category by name', 'get_category_by_name'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end
	end

	describe 'Get materials for chat responses' do

		context 'with params' do
			include_context 'get chat response', 'get_marvels'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end
	end

	describe 'Get materials by name' do

		context 'with empty params' do
			let(:a_marvel) { nil }
			include_context 'get materials by name', 'get_marvel_by_name'
			include_examples 'expect bad request response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

		context 'with params' do
			let(:a_marvel) { create(:marvel) }
			let(:material_name) { a_marvel.name }
			include_context 'get materials by name', 'get_marvel_by_name'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end

	describe 'Get products by name' do

		context 'with empty params' do
			let(:a_product) { nil }
			include_context 'get products by name', 'get_product_by_name'
			include_examples 'expect bad request response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

		context 'with params' do
			let(:a_product) { create(:marvel) }
			let(:product_name) { a_product.name }
			include_context 'get products by name', 'get_product_by_name'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end

		end

	end

	describe 'Get budget by material' do

		context 'with empty params' do
			include_context 'get budget by material', 'get_budget_by_material'
			include_examples 'expect bad request response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end
		end

		context 'with params' do
			let(:a_marvel) { create(:marvel) }
			let(:material_name) { a_marvel.name }
			include_context 'get budget by material', 'get_budget_by_material'
			include_examples 'expect successful response'

			it 'should respond a DialogFlow response' do
				expect(response.body).to match_response_schema('dialog-flow-response')
			end
		end

	end


end
