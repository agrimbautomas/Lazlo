require 'rails_helper'

RSpec.describe PendingPurchase do
  include MercadoPagoHelper

  let(:user) { create(:user_with_checkout_list) }
  let!(:product) { create(:product) }

  before {

	 params = ActionController::Parameters.new
	 params[:user] = user
	 params[:product] = product
	 params[:mercado_pago_params] = mercado_pago_params(user, product)
	 
	 @cart_checkout = PendingPurchase.(params)
  }

  describe 'single_checkout method' do

	 before { @cart_checkout.single_checkout }

	 it 'matches the checkout link from mercado pago' do
		expect(Order).to have(1).record
	 end

  end

end