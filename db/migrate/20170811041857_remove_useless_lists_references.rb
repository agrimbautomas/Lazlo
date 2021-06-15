class RemoveUselessListsReferences < ActiveRecord::Migration[4.2]
  def change
	 remove_reference :orders, :purchased_list, index: true, null: true
	 add_reference :orders, :products_list, index: true, null: true

	 remove_reference :mercado_pago_purchases, :checkout_list, null: false, index: true
	 add_reference :mercado_pago_purchases, :products_list, index: true

	 remove_reference :product_rows, :favourites_list, foreign_key: true, index: true
	 remove_reference :product_rows, :checkout_list, foreign_key: true, index: true
	 remove_reference :product_rows, :purchased_list, foreign_key: true, index: true

	 add_reference :product_rows, :products_list, foreign_key: true, index: true
  end
end
