class AddColorToOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :color, :string
  end
end
