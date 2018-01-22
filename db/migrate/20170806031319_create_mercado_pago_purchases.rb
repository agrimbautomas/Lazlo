class CreateMercadoPagoPurchases < ActiveRecord::Migration[4.2]
  def change
	 create_table :mercado_pago_purchases do |t|

		t.references :user, null: false, index: true
		t.references :checkout_list, null: false, index: true

		t.string :collection_id
		t.string :preference_id
		t.string :payment_type
		t.integer :status, null: false

		t.timestamps null: false
	 end
  end
end
