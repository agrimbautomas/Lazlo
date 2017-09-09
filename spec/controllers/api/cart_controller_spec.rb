require 'rails_helper'

RSpec.describe Api::V1::CartController, type: :controller do

  let(:product) {create(:product)}

  describe 'CRUD products in user cart' do

	 context 'POST product to user cart' do
		before {
		  post :add_product_to_cart, product_id: product.id
		}

		it {
		  expect(response.status).to eq 200
		  expect(response.content_type).to eq('application/json')
		}

		it 'should respond success and update the cart' do
		  expect(response.body).to match_response_schema('question-response')
		end

	 end
  end
end
