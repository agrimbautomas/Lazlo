# == Schema Information
#
# Table name: products_lists
#
#  id         :integer          not null, primary key
#  type       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CheckoutList, type: :model do

  it { should respond_to(:user) }
  it { should respond_to(:product_rows) }

  it { should belong_to (:user) }
  it { should have_many(:product_rows) }


  describe '#create!' do
	 let(:valid_checkout_list) { create(:checkout_list) }
	 let(:user) { create(:user) }
	 let(:product) { create(:product) }

	 context 'with correct params' do
		it { expect(valid_checkout_list).to be_valid }
	 end

	 it 'should create list if is not there' do
		user.add_product_to_cart product
		expect(user.checkout_list).to be_valid
	 end

	 it 'should have a CheckoutList as Object' do
		user.add_product_to_cart product
		expect(user.checkout_list).to be_a(CheckoutList)
	 end

	 it 'should have product rows' do
		user.add_product_to_cart product
		expect(user.checkout_list).to have_at_least(1).product_rows
	 end

	 it 'should have added product as in last row' do
		user.add_product_to_cart product
		expect(user.checkout_list.product_rows.last.product).to eq(product)
	 end

  end
end
