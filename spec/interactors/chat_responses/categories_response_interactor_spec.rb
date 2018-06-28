require 'rails_helper'
require 'contexts/for_models'

RSpec.describe CategoriesResponse do

	context 'with correct params' do
		it {
			expect(response.status).to eq 200
			expect(response.content_type).to eq('application/json')
		}

		it 'should respond a DialogFlow response' do
			expect(response.body).to match_response_schema('dialog-flow-response')
		end

	end
end
