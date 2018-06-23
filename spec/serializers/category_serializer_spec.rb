require 'rails_helper'
require 'contexts/for_models'

RSpec.describe CategorySerializer do
	include_context 'create category'
	let(:category_serialization) {
		ActiveModelSerializers::SerializableResource.new(category, {}).to_json
	}

	it 'renders the category correctly' do
		expect(category_serialization).to eq(
			{
				id: category.id,
				name: category.name,
				description: category.description
			}.to_json
		)
	end
end
