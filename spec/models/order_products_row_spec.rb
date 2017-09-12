require 'rails_helper'

RSpec.describe OrderProductsRow, type: :model do

  it {should respond_to (:order_products_list)}
  it {should belong_to (:order_products_list)}

  it {should respond_to (:product)}
  it {should belong_to (:product)}

  let(:valid_order_products_row) {create(:order_products_row)}

  describe '#create!' do
	 context 'with correct params' do
		it {expect(valid_order_products_row).to be_valid}
	 end
  end

  describe 'instance methods' do
	 context 'with products' do
		it {
		  valid_order_products_row.product_price = 2
		  valid_order_products_row.quantity = 3

		  expect(valid_order_products_row.total).to be(6)
		}
	 end

	 context 'with products' do
		it {
		  expect(valid_order_products_row.formatted_total).to eq("$#{valid_order_products_row.total}")
		}
	 end
  end

end
