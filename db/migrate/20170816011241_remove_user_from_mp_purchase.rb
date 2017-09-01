class RemoveUserFromMpPurchase < ActiveRecord::Migration
  def change
	 remove_reference :mercado_pago_purchases, :user, index: true
  end
end
