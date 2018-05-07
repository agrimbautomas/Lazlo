require 'rails_helper'

RSpec.describe SaveAdminOrder do

  let(:order) { create(:order) }
  let(:buyer) { create(:buyer) }
  let(:order_status) { create(:order_status) }

  before {
	 order_params = ActionController::Parameters.new(
		  :buyer_id => buyer.id,
		  :user_id => nil,
		  :detail => "Algun detalle",
		  :order_status_id => order_status.id.to_s,
		  :title => "Algun titulo",
		  :payment => "32323"
	 )

	 params = ActionController::Parameters.new(
		  :order_params => order_params,
		  :order => order
	 )

	 @cart_checkout = SaveAdminOrder.(params)
  }

  describe 'update_ordermethod' do

	 it 'should return an Order' do
		expect(@cart_checkout.save_or_update_order).to be_instance_of(Order)
	 end

  end

end