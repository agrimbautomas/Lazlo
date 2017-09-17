require 'rails_helper'

RSpec.describe MercadoPagoSingleCheckout do

  let(:user) {create(:user)}
  let!(:product) {create(:product)}

  context 'with correct params' do

	 before {
		params = ActionController::Parameters.new
		params[:user] = user
		params[:product] = product
		@single_checkout = MercadoPagoSingleCheckout.(parameters: params, delegate: self)
	 }

	 it 'matches the checkout link from mercado pago' do
		expect(@single_checkout.checkout).to match('/sandbox.mercadopago.com/')
	 end

	 it 'should return an array' do
		expect(@single_checkout.send(:items_to_json)).to be_a(Array)
	 end

	 it 'should have a hash of Product with data' do
		expect(@single_checkout.send(:items_to_json).first).to be_a(Hash)
	 end

	 it 'should have the key id in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('id')
	 end
	 it 'should have the key title in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('title')
	 end
	 it 'should have the key description in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('description')
	 end
	 it 'should have the key quantity in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('quantity')
	 end
	 it 'sho<uld have the key unit_price in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('unit_price')
	 end

	 it 'sho<uld have the key currency_id in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('currency_id')
	 end

	 it 'sho<uld have the key picture_url in hash' do
		expect(@single_checkout.send(:items_to_json).first).to have_key('picture_url')
	 end
	 
  end
end