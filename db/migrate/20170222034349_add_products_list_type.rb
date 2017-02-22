class AddProductsListType < ActiveRecord::Migration
  def change
    add_column :products_lists, :type, :integer
  end
end
