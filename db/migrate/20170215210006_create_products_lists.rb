class CreateProductsLists < ActiveRecord::Migration
  def change
    create_table :products_lists do |t|
      t.belongs_to :user

      t.timestamps null: false
    end

  end
end
