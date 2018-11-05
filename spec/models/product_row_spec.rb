require 'rails_helper'
require 'contexts/for_models'

RSpec.describe ProductRow, type: :model do

	it { should respond_to (:product) }
	it { should belong_to (:product) }
	it { should validate_presence_of (:product) }

	it { should respond_to (:quantity) }
	it { should validate_presence_of (:quantity) }
	it { should validate_numericality_of(:quantity).is_greater_than(0) }

	describe '#create!' do
		let!(:valid_product_row) { create(:product_row) }

		context 'with correct params' do
			it { expect(valid_product_row).to be_valid }
		end

		context 'with same product and quantity' do
			it { expect(
				ProductRow.create(
					product: valid_product_row.product,
					quantity: valid_product_row.quantity
				)
			).not_to be_valid }
		end

	end

end
