class AddPhoneToBuyer < ActiveRecord::Migration[4.2]
  def change
    add_column :buyers, :phone, :string
  end
end
