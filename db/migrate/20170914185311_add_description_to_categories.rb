class AddDescriptionToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :description, :string
  end
end
