class AddProductsListCategory < ActiveRecord::Migration
  def change
    add_column :products_lists, :category, :integer
  end
end
