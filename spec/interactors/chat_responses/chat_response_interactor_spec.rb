require 'rails_helper'
require 'contexts/for_models'

RSpec.describe ChatResponseInteractor do

	context 'with correct stock url' do
		let( :product ) { create :product, external_id: '109-1351', name: 'REMERA BLAIR' }
		let( :color ) { create :color, external_id: '1G', name: 'CRUDO' }
		let( :stock ) { create :stock, product: product, color: color }
		it 'must be valid' do
			expect( FindProductsImages.with( search_url: stock.search_url ).count > 0 ).to eq true
		end
	end

	context 'with params' do
		it 'should respond a DialogFlow response' do
			expect(response.body).to match_response_schema('dialog-flow-response')
		end

	end
end
