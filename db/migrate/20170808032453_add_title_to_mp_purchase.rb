class AddTitleToMpPurchase < ActiveRecord::Migration[4.2]
  def change
	 add_column :mercado_pago_purchases, :title, :string
  end
end
