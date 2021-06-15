class AddOrderToMercadoPagoPurchase < ActiveRecord::Migration[4.2]
  def self.down
	 remove_column :mercado_pago_purchases, :title
	 remove_reference :mercado_pago_purchases, :products_list
	 remove_reference :orders, :mercado_pago_purchase
  end
end
