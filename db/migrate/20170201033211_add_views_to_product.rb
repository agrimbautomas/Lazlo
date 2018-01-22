class AddViewsToProduct < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :views, :integer, :default => 0
    add_column :products, :views, :integer, :default => 0
  end
end
