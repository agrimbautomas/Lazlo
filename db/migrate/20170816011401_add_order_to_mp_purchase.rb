class AddOrderToMpPurchase < ActiveRecord::Migration
  def change
	 add_reference :mercado_pago_purchases, :order, index: true, null: false
  end
end
