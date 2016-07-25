class CreateMarvels < ActiveRecord::Migration
  def change
    create_table :marvels do |t|
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
