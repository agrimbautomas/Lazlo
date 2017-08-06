# == Schema Information
#
# Table name: mercado_pago_purchases
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  checkout_list_id :integer          not null
#  collection_id    :string
#  prefrence_id     :string
#  payment_type     :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class MercadoPagoPurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
