class AddOrderProductsListToOrder < ActiveRecord::Migration
  def self.up
	 add_reference :orders, :order_products_list, index: true, foreign_key: true
  end

  def self.down
	 remove_reference :orders, :products_list, index: true, foreign_key: true
  end
end
