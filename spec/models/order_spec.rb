# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  buyer_id                 :integer
#  product_id               :integer
#  code                     :string(255)
#  detail                   :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  order_status_id          :integer
#  tracking_title           :string(255)
#  payment                  :integer
#  color                    :string(255)
#  mercado_pago_purchase_id :integer
#  purchased_list_id        :integer
#  user_id                  :integer
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
