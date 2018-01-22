class AddOrderToMpPurchase < ActiveRecord::Migration[4.2]
  def change
	 unless table_exists?(:mercado_pago_purchases)
		add_reference :mercado_pago_purchases, :order, index: true
	 end
  end
end
