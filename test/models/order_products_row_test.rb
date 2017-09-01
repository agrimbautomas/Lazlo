# == Schema Information
#
# Table name: order_products_rows
#
#  id                     :integer          not null, primary key
#  order_products_list_id :integer
#  product_id             :integer
#  quantity               :integer
#  product_name           :string(255)
#  product_price          :float(24)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class OrderProductsRowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
