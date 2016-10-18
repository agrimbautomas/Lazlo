class AddSaltToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_salt, :string, limit: 32, after: :encrypted_password
  end
end
