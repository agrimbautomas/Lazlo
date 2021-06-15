class AddMpPurchaseToOrder < ActiveRecord::Migration[4.2]
  def change
	 add_reference :orders, :mercado_pago_purchase, index: true, foreign_key: true, null: true
  end
end
