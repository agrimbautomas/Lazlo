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

  let (:john) { create(:user) }

  let(:current_user) { User.first }
  let(:category) { create(:category) }
  let(:a_product) { Product.new(name: 'Another fake Product', price: 5000, category: category,
                                description: 'Some random description') }

  context 'on model validations' do
    it { should respond_to(:user) }
    it { should respond_to(:product_rows) }

    it { should belong_to (:user) }
    it { should have_many(:product_rows) }
  end

  describe 'when is created' do
    it 'should have validations params' do
      checkout_list = CheckoutList.create(:user => current_user)
      expect(checkout_list).to be_valid
    end

  end

  describe 'when user CRUDs products of the cart it' do

    it 'should create list if is not there' do
      a_user = User.new email: 'mike42@theamalgama.com', password: 'asd789de', password_confirmation: 'asd789de'
      a_user.add_product_to_cart a_product
      expect(a_user.checkout_list).to be_valid
    end

    it 'should have a CheckoutList as Object' do
      john.add_product_to_cart a_product
      expect(john.checkout_list).to be_a(CheckoutList)
    end

    it 'should have product rows' do
      john.add_product_to_cart a_product
      expect(john.checkout_list).to have_at_least(1).product_rows
    end

    it 'should have added product as in last row' do
      john.add_product_to_cart a_product
      expect(john.checkout_list.product_rows.last.product).to eq(a_product)
    end

  end
end
