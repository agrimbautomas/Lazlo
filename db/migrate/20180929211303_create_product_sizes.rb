class CreateProductSizes < ActiveRecord::Migration[5.1]
	def change
		create_table :product_sizes do |t|
			t.string :name, null: false
			t.float :price, null: false
			t.references :product, index: true
		end
		remove_column :products, :price
	end
end
