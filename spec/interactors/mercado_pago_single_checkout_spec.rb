require 'rails_helper'

RSpec.describe MercadoPagoSingleCheckout do

  let(:user) {create(:user)}
  let!(:product) {create(:product)}

  context 'with correct params' do

	 before {
		params = ActionController::Parameters.new
		params[:user] = user
		params[:product] = product
		@checkout_link = MercadoPagoSingleCheckout.(parameters: params, delegate: self).checkout
	 }

	 it 'matches the checkout link from mercado pago' do
		expect(@checkout_link).to match('/sandbox.mercadopago.com/')
	 end
  end
end