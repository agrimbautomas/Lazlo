# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  buyer_id        :integer
#  product_id      :integer
#  code            :string
#  detail          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_status_id :integer
#  tracking_title  :string
#  payment         :integer
#  color           :string
#

require 'rails_helper'

RSpec.describe Order, type: :model do

  it { should validate_presence_of(:buyer) }
  it { should validate_presence_of(:product) }

  it { should belong_to (:buyer) }
  it { should belong_to (:product) }

  let (:one_order) { Order.create! buyer: Buyer.create(:name => 'SomeBuyer'), product: Product.create(:name => 'One product') }

  context 'on Create' do
    it 'should have code after created' do
      expect(one_order.code).to be_present
    end

  end

end
