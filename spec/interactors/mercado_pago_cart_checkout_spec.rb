require 'rails_helper'

RSpec.describe MercadoPagoCartCheckout do

  let(:user) { create(:user_with_checkout_list) }
  let!(:product) { create(:product) }

  before {
	 params = ActionController::Parameters.new
	 params[:user] = user
	 @cart_checkout = MercadoPagoCartCheckout.(parameters: params, delegate: self)
  }

  describe 'checkout method' do

	 it 'matches the checkout link from mercado pago' do
		expect(@cart_checkout.checkout).to match('/sandbox.mercadopago.com/')
	 end

  end

  describe 'purchase_title method' do

	 it 'should return the purchase_title' do
		@cart_checkout.send(:items_to_json)
		expect(@cart_checkout.send(:purchase_title)).to match(I18n.t('checkout_purchase_title'))
	 end

  end

  describe 'back_urls_json method' do

	 it 'should have the key pending in hash' do
		expect(@cart_checkout.send(:back_urls_json)).to have_key('pending')
	 end
	 it 'should have the key success in hash' do
		expect(@cart_checkout.send(:back_urls_json)).to have_key('success')
	 end
	 it 'should have the key pending in hash' do
		expect(@cart_checkout.send(:back_urls_json)).to have_key('pending')
	 end

  end

  describe 'purchase_data method' do
	 before { @cart_checkout.send(:items_to_json) }

	 it 'should have the key title in hash' do
		expect(@cart_checkout.send(:purchase_data)).to have_key('title')
	 end

	 it 'should have the key product_rows in hash' do
		expect(@cart_checkout.send(:purchase_data)).to have_key('product_rows')
	 end

  end

  describe 'items_to_json method' do

	 it 'should return an array' do
		expect(@cart_checkout.send(:items_to_json)).to be_a(Array)
	 end
	 it 'should have a hash of Product with data' do
		expect(@cart_checkout.send(:items_to_json).first).to be_a(Hash)
	 end
	 it 'should have the key id in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('id')
	 end
	 it 'should have the key title in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('title')
	 end
	 it 'should have the key description in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('description')
	 end
	 it 'should have the key quantity in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('quantity')
	 end
	 it 'sho<uld have the key unit_price in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('unit_price')
	 end
	 it 'sho<uld have the key currency_id in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('currency_id')
	 end
	 it 'sho<uld have the key picture_url in hash' do
		expect(@cart_checkout.send(:items_to_json).first).to have_key('picture_url')
	 end

  end
end