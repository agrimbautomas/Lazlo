class CreateOrderProductsRows < ActiveRecord::Migration
  def change
    create_table :order_products_rows do |t|
		t.belongs_to :order_products_list
		t.belongs_to :product

		t.integer :quantity
		t.string :product_name
		t.float :product_price

      t.timestamps null: false
    end
  end
end
