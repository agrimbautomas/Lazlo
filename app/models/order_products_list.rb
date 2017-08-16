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
  has_many :order_products_rows

  def self.create_from_list products_list
	 new_list = OrderProductsList.create
	 products_list.product_rows.each do |product_row|
		new_list.order_products_rows << OrderProductsRow.from_product_row(product_row)
	 end
	 new_list
  end

end
