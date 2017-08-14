class RemoveProductFromOrders < ActiveRecord::Migration
  def change
	 remove_reference :orders, :products, index: true, foreign_key: true
  end
end
