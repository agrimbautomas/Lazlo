class AddPhoneToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :phone, :string
  end
end
