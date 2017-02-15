class CreateProductRows < ActiveRecord::Migration
  def change
    create_table :product_rows do |t|

      t.integer :quantity, default: 1
      t.timestamps null: false
    end

    add_reference :product_rows, :product, foreign_key: true

  end

end
