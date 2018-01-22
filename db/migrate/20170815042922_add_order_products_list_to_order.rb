class AddOrderProductsListToOrder < ActiveRecord::Migration[4.2]
  def self.up
	 add_reference :orders, :order_products_list, index: true, foreign_key: true
  end

  def self.down
	 remove_reference :orders, :products_list, index: true, foreign_key: true
  end
end
