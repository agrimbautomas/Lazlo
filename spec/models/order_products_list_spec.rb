require 'rails_helper'

RSpec.describe OrderProductsList, type: :model do

  it {should respond_to (:order)}
  it {should belong_to (:order)}

  it {should respond_to (:order_products_rows)}
  it {should have_many (:order_products_rows)}

  let(:valid_order_products_list) {create(:order_products_list)}
  let(:valid_product) {create(:product)}

  describe '#create!' do

	 context 'with correct params' do
		it {expect(valid_order_products_list).to be_valid}
	 end
  end

  describe 'instance methods' do
	 context 'with products' do
		it {
		  expect(OrderProductsList.create_from_product(valid_product)).to be_a(OrderProductsList)
		}
	 end

	 context 'with products' do
		it {
		  expect(valid_order_products_list.formatted_total).to eq("$#{valid_order_products_list.total}")
		}
	 end
  end

end
