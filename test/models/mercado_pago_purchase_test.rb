# == Schema Information
#
# Table name: mercado_pago_purchases
#
#  id            :integer          not null, primary key
#  collection_id :string
#  preference_id :string
#  payment_type  :string
#  status        :string           default("initial"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  order_id      :integer
#

require 'test_helper'

class MercadoPagoPurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
