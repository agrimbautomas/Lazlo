class CreateProductPrices < ActiveRecord::Migration[5.1]
	def change
		create_table :product_prices do |t|
			t.float :price, null: false
			t.references :product, index: true
			t.references :product_size, index: true
			t.timestamps
		end

		remove_column :products, :price
	end
end
