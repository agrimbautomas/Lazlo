class RemoveTitleAndListFromMpPurchase < ActiveRecord::Migration
  def change
	 remove_reference :mercado_pago_purchases, :products_list, index: true
	 remove_column :mercado_pago_purchases, :title
	 rename_column :orders, :tracking_title, :title
  end
end
