class RemoveProductFromOrders < ActiveRecord::Migration
  def self.down
	 remove_reference :orders, :products, index: true, foreign_key: true
  end
end
