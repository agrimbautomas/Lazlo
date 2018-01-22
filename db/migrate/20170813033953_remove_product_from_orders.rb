class RemoveProductFromOrders < ActiveRecord::Migration[4.2]
  def self.down
	 remove_reference :orders, :products, index: true, foreign_key: true
  end
end
