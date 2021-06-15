class AddSlugToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :slug, :string, :unique => true
  end
end
