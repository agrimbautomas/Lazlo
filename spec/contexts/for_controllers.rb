require 'contexts/for_models'

RSpec.shared_context 'stub doorkeeper' do
	let(:token) { double :acceptable? => true }
	before do
		allow(controller).to receive(:current_user) { user }
	end
end

RSpec.shared_context 'stub devise' do
	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:user]
		sign_in user
	end
end

RSpec.shared_context 'stub devise for admin' do
	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:admin]
		sign_in FactoryBot.create(:admin)
	end
end

