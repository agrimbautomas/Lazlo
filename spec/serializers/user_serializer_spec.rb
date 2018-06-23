require 'rails_helper'
require 'contexts/for_models'

RSpec.describe UserSerializer do
	include_context 'create user', :user
	let(:user_serialization) {
		ActiveModelSerializers::SerializableResource.new(user, {}).to_json
	}

	it 'renders the user correctly' do
		expect(user_serialization).to eq(
			{
				id: user.id,
				name: user.name,
				email: user.email
			}.to_json
		)
	end
end
