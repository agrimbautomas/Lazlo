class AddSlugProductType < ActiveRecord::Migration
  def change
    add_column :product_types, :slug, :string, :unique => true
  end
end
