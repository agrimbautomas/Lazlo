class RemoveProductsListFromOrders < ActiveRecord::Migration
  def change
	 remove_reference :orders, :products_list, index: true
  end
end
