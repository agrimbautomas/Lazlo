class AddSaltToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :password_salt, :string, limit: 32, after: :encrypted_password
  end
end
