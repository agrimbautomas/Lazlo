class AddMpPurchaseToOrder < ActiveRecord::Migration
  def change
	 add_reference :orders, :mercado_pago_purchase, index: true, foreign_key: true, null: true
  end
end
