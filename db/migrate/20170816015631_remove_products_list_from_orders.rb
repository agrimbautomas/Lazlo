class RemoveProductsListFromOrders < ActiveRecord::Migration[4.2]
  def change
	 remove_reference :orders, :products_list, index: true
  end
end
