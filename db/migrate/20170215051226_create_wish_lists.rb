class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.belongs_to :user
      t.reference :product_list

      t.timestamps null: false
    end
  end
end
