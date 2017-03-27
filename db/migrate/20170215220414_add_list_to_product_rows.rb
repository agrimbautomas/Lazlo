class AddListToProductRows < ActiveRecord::Migration
  def change
    add_reference :product_rows, :favourites_list, foreign_key: true, index: true
    add_reference :product_rows, :checkout_list, foreign_key: true, index: true
    add_reference :product_rows, :purchased_list, foreign_key: true, index: true
  end
end
