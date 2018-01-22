class AddSlugProductType < ActiveRecord::Migration[4.2]
  def change
    add_column :product_types, :slug, :string, :unique => true
  end
end
