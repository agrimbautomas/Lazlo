class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.string :name
      t.string :email, unique: true
      t.text :message

      t.timestamps null: false
    end
  end
end
