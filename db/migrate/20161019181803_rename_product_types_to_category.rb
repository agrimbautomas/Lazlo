class RenameProductTypesToCategory < ActiveRecord::Migration[4.2]
  def change
    remove_reference(:products, :product_type, index: true, foreign_key: true)
    rename_table :product_types, :categories
    add_reference :products, :category, index: true, foreign_key: true
  end
end
