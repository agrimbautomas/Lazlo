# == Schema Information
#
# Table name: order_products_lists
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderProductsList < ActiveRecord::Base
  belongs_to :order
  has_many :product_rows
end
