class CreateFavouritesList < ActiveRecord::Migration
  def change
    create_table :favourites_lists do |t|
      t.belongs_to :user
      t.timestamps null: false
    end

    create_table :checkout_lists do |t|
      t.belongs_to :user
      t.timestamps null: false
    end

    create_table :purchased_lists do |t|
      t.belongs_to :user
      t.timestamps null: false
    end

  end
end
