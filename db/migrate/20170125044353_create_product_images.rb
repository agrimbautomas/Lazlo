class CreateProductImages < ActiveRecord::Migration[4.2]
  def change
    create_table :product_images do |t|
      t.belongs_to :product

      t.timestamps null: false
    end
  end
end
