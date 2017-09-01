# == Schema Information
#
# Table name: mercado_pago_purchases
#
#  id            :integer          not null, primary key
#  collection_id :string(255)
#  preference_id :string(255)
#  payment_type  :string(255)
#  status        :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class MercadoPagoPurchaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
