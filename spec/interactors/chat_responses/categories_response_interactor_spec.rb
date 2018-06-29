require 'rails_helper'
require 'contexts/for_models'

RSpec.describe CategoriesResponse do
	let!(:a_category) { create(:category, name: 'Mesas de Arrime') }
	let(:chat_params) { { product_category: a_category.name } }

	context "when parameters are valid" do
		context "when the chat get a category response by name" do
			let!(:categories_response) {
				CategoriesResponse.by_name(chat_params: chat_params)
			}

			it "creates a categories response" do
				expect(categories_response).not_to be_empty
			end

		end

	end

end
