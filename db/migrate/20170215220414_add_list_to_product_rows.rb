class AddListToProductRows < ActiveRecord::Migration
  def change
    add_reference :product_rows, :products_list, foreign_key: true, index: true
  end
end
