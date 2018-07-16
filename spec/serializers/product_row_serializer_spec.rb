require 'rails_helper'
require 'contexts/for_models'

RSpec.describe ProductRowSerializer do
	include_context 'create product row'
	let(:product_serialization) {
		ActiveModelSerializers::SerializableResource.new(product_row, {}).to_json
	}

	it 'renders the product row correctly' do
		expect(product_serialization).to eq(
			{
				quantity: product_row.quantity,
				total: product_row.total,
				product: product_row.product,
			}.to_json
		)
	end


end
