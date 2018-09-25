require 'rails_helper'
require 'contexts/for_models'

RSpec.describe Order, type: :model do

	it { should respond_to (:buyer) }
	it { should belong_to (:buyer) }

	it { should respond_to (:user) }
	it { should belong_to (:user) }

	it { should respond_to (:mercado_pago_purchase) }
	it { should belong_to (:mercado_pago_purchase) }

	it { should respond_to (:order_products_list) }
	it { should have_one (:order_products_list) }

	it { should respond_to (:order_products_rows) }
	it { should have_many (:order_products_rows) }
	it { should accept_nested_attributes_for (:order_products_rows) }

	it { should respond_to (:payment_type) }
	it { should validate_presence_of (:payment_type) }

	it { should respond_to (:title) }
	it { should validate_presence_of (:title) }
	it { should validate_length_of(:title).is_at_most(255) }

	it { should respond_to (:detail) }
	it { should validate_length_of(:detail).is_at_most(255) }

	it { should respond_to (:code) }
	it { should validate_length_of(:code).is_at_most(255) }

	it { should respond_to (:status) }
	it { expect define_enum_for(:status).with [:requested, :in_blacksmith,
		:in_painting, :finished, :delivered, :cancelled] }

	it { should respond_to (:document) }
	it { should have_attached_file(:document) }

	describe '#create!' do
		include_context 'create order'

		context 'with correct params' do
			it 'should be a creation valid' do
				expect(order).to be_valid
			end
		end

		context 'when calls human_enum_name with correct params' do
			it 'should return a readable string' do
				order.status = Order.statuses[:in_painting]
				expect(Order.human_enum_name(:status, order.status)).to eq 'Pintura'
			end
		end

		context 'when gets cart_order_statuses' do
			it 'should not return cancelled status' do
				expect(Order.cart_order_statuses).not_to include(:cancelled)
			end
		end

	end

end
