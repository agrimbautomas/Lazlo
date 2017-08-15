class AddOrderToMercadoPagoPurchase < ActiveRecord::Migration
  add_reference :mercado_pago_purchases, :order, index: true, foreign_key: true

  remove_column :mercado_pago_purchases, :title
  remove_reference :mercado_pago_purchases, :products_list
  remove_reference :orders, :mercado_pago_purchase
end
