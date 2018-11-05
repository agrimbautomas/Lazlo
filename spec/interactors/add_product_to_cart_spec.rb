require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'AddProductToCart is succesful' do
	it 'the creation is succesful and the owner was added as a member' do
		expect { add_product }.to change(ProductRow, :count).by 1
		expect(user.checkout_list.product_rows.pluck(:product_id)).to include product.id
	end
end

RSpec.shared_examples 'AddProductToCart raises an exception' do
	it {
		expect { add_product }.to raise_exception Error
	}
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

	context 'when product has already been added to cart' do
		before {
			AddProductToCart.with user: user, product: product, quantity: 3
			AddProductToCart.with user: user, product: product, quantity: 20
		}
		it 'should be updated' do
			expect(
				user.checkout_list.product_rows.find_by(:product => product).quantity
			).to eq 20
		end
	end

	context 'without user' do
		let(:user){ nil }
		include_examples 'AddProductToCart raises an exception'
	end

	context 'without product' do
		let(:product){ nil }
		include_examples 'AddProductToCart raises an exception'
	end

end
