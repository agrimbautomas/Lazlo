class RemoveUserFromMpPurchase < ActiveRecord::Migration[4.2]
  def change
	 remove_reference :mercado_pago_purchases, :user, index: true
  end
end
