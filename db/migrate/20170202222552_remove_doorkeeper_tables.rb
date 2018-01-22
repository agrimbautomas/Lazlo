class RemoveDoorkeeperTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :oauth_applications
    drop_table :oauth_access_grants
    drop_table :oauth_access_tokens
  end
end
