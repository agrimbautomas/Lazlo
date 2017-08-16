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

class OrderProductsRow < ActiveRecord::Base

  belongs_to :order_products_list
  belongs_to :product

  validates_presence_of :product, :product_name, :product_price, :quantity

  def self.from_product_row product_row
	 OrderProductsRow.create(
		  product: product_row.product,
		  product_name: product_row.product.name,
		  product_price: product_row.product.price,
		  quantity: product_row.quantity,
	 )
  end

end
