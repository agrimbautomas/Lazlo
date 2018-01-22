class CreateMarvels < ActiveRecord::Migration[4.2]
  def change
    create_table :marvels do |t|
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
