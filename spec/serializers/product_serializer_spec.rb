require 'rails_helper'
require 'contexts/for_models'

RSpec.describe ProductSerializer do
	include_context 'create product'
	let(:product_serialization) {
		ActiveModelSerializers::SerializableResource.new(product, {}).to_json
	}

	it 'renders the product correctly' do
		expect(product_serialization).to eq(
			{
				id: product.id,
				name: product.name,
				price: product.price
			}.to_json
		)
	end
end
