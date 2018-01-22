class CreateProductsLists < ActiveRecord::Migration[4.2]
  def self.up
	 if !table_exists?("products_lists")
		create_table :products_lists do |t|
		  t.string :type
		  t.belongs_to :user
		  t.timestamps null: false
		end
	 end
  end

  def self.down
	 drop_table :favourites_lists
	 drop_table :checkout_lists
	 drop_table :purchased_lists
  end

end
