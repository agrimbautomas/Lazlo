# == Schema Information
#
# Table name: order_products_lists
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe OrderProductsList, type: :model do

	it { should respond_to (:order) }
	it { should belong_to (:order) }

	it { should respond_to (:order_products_rows) }
	it { should have_many (:order_products_rows) }

	let(:valid_order_products_list) { create(:order_products_list) }
	let(:valid_product) { create(:product) }

	describe '#create!' do

		context 'with correct params' do
			it { expect(valid_order_products_list).to be_valid }
		end
	end

	describe 'instance methods' do
		context 'with products' do
			it {
				expect(OrderProductsList.create_from_product(valid_product)).to be_a(OrderProductsList)
			}


			it 'should return the total price of all the products' do
				expect(valid_order_products_list.total).to be > 0
			end

			it 'should return the total price of all the products as Integer or Float' do
				expect(valid_order_products_list.total).to be_a(Integer).or(be_a(Float))
			end

			it 'should have at least one product row' do
				expect(valid_order_products_list).to have_at_least(1).order_products_rows
			end
		end

	end

end
