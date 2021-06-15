class AddAddressToBuyers < ActiveRecord::Migration[4.2]
  def change
    add_column :buyers, :address, :string
  end
end
