require 'rails_helper'
require 'shared_examples/for_controllers'
require 'contexts/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'create favourites' do
	before { post :create, params: { product_id: product.id } }
end

RSpec.shared_context 'destroy favourites' do
	before { delete :destroy, params: { product_id: product_id } }
end


RSpec.describe Api::V1::FavouritesController, type: :controller do
	let( :product ) { create :product }

	describe 'Create favourite' do
		context 'without token' do
			let( :product_id ) { 1 }

			include_context 'create favourites'
			include_examples 'expect redirect response'
		end

		describe 'with token' do
			include_context 'create user with device'

			context 'with correct id' do
				include_context 'create product'
				let( :favourite ) { create :favourite, product: product, user: user }
				include_context 'create favourites'
				include_examples 'expect redirect response'
			end

		end
	end

end
