require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'AddProductToCart is succesful' do
	it 'the creation is succesful and the owner was added as a member' do
		expect { @project = add_product }.to change(ProductRow, :count).by 1
		#expect(@project.members.pluck(:user_id)).to include owner.id
	end
end

RSpec.describe AddProductToCart do
	include_context 'create user', :user
	include_context 'create product'

	let (:add_product) {
		AddProductToCart.with(
			user: user,
			product: product,
			quantity: 3)
	}

	context 'with correct params' do
		include_examples 'AddProductToCart is succesful'
	end

	context 'when product has already been marked as a favourite' do
		include_context 'create favourite'
		it {
			expect {
				AddProductToCart.with user: user, product: favourite.product, quantity: 3
			}.to raise_exception Error
		}
	end

	context 'without user' do
		it {
			expect {
				AddProductToCart.with user: nil, product: product, quantity: 3
			}.to raise_exception Error
		}
	end

	context 'without product' do
		it {
			expect {
				AddProductToCart.with user: user, product: nil, quantity: 3
			}.to raise_exception Error
		}
	end
end
