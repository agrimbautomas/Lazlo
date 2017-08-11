class RemoveUselessListsReferences < ActiveRecord::Migration
  def change
	 remove_reference :orders, :purchased_list, index: true, null: true

	 remove_reference :product_rows, :favourites_list, foreign_key: true, index: true
	 remove_reference :product_rows, :checkout_list, foreign_key: true, index: true
	 remove_reference :product_rows, :purchased_list, foreign_key: true, index: true

	 add_reference :product_rows, :products_list, foreign_key: true, index: true
  end
end
