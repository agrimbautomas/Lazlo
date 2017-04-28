require 'rails_helper'

RSpec.describe CheckoutList, type: :model do

  let(:current_user) { User.first }
  let(:category1) { Category.create!(name: 'Mesa Ratona') }
  let(:a_product) { Product.new(name: 'Another fake Product', price: 5000, category: category1,
                                description: 'Some random description, some random description') }
  it { should respond_to(:user) }
  it { should respond_to(:product_rows) }

  it { should belong_to (:user) }
  it { should have_many(:product_rows) }


  context 'when is created' do
    it 'should have validations params' do
      checkout_list = CheckoutList.create(:user => current_user)
      expect(checkout_list).to be_valid
    end

    it 'should have save product row' do
      checkout_list = CheckoutList.create(:user => current_user)
      expect(checkout_list).to be_valid
    end

  end

end
