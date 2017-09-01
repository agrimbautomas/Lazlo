class AddTitleToMpPurchase < ActiveRecord::Migration
  def change
	 add_column :mercado_pago_purchases, :title, :string
  end
end
