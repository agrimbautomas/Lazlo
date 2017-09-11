# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  buyer_id                 :integer
#  product_id               :integer
#  code                     :string
#  detail                   :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  order_status_id          :integer
#  title                    :string
#  payment                  :integer
#  color                    :string
#  mercado_pago_purchase_id :integer
#  user_id                  :integer
#  order_products_list_id   :integer
#  payment_type             :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do

  it { should respond_to (:buyer) }
  it { should belong_to (:buyer) }

  it { should respond_to (:user) }
  it { should belong_to (:user) }

  it { should respond_to (:order_status) }
  it { should belong_to (:order_status) }

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
  it { should validate_presence_of (:code) }
  it { should validate_length_of(:code).is_at_most(255) }

  it { should respond_to (:tracking_link) }

  describe '#create!' do
    let(:valid_order) { create(:order) }

    context 'with correct params' do
      it { expect(valid_order).to be_valid }
    end

  end

end
