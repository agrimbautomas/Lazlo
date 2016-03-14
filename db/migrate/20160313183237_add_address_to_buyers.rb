class AddAddressToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :address, :string
  end
end
