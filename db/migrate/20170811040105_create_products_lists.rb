class CreateProductsLists < ActiveRecord::Migration
  def change
    create_table :products_lists do |t|
		t.string :type
		t.belongs_to :user
      t.timestamps null: false
	 end

	 drop_table :favourites_lists
	 drop_table :checkout_lists
	 drop_table :purchased_lists
  end
end
