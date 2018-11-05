require 'rails_helper'
require 'contexts/for_models'

RSpec.shared_examples 'CreateProductRow is succesful' do
	it 'the creation is succesful and the owner was added as a member' do
		expect { @product_row = product_row }.to change(ProductRow, :count).by 1
	end
end

RSpec.describe CreateProductRow do
	include_context 'create user', :user
	include_context 'create product'

	let (:product_row) {
		CreateProductRow.with(
			checkout_list: user.checkout_list,
			product: product,
			quantity: 3)
	}

	context 'with correct params' do
		include_examples 'CreateProductRow is succesful'
	end

	context 'with same product and different quantity' do
		before {
			CreateProductRow.with checkout_list: user.checkout_list, product: product, quantity: 3
			CreateProductRow.with checkout_list: user.checkout_list, product: product, quantity: 20
		}

		it 'should update existing ProductRow' do
			expect(user.checkout_list.product_rows.find_by(:product => product).quantity).to eq 20
		end
	end

	context 'without checkout_list' do
		it {
			expect {
				CreateProductRow.with checkout_list: nil, product: product, quantity: 3
			}.to raise_exception Error
		}
	end

	context 'without product' do
		it {
			expect {
				CreateProductRow.with checkout_list: user.checkout_list, product: nil, quantity: 3
			}.to raise_exception Error
		}
	end

end
