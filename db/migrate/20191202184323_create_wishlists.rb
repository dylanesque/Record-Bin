class CreateWishlists < ActiveRecord::Migration[6.0]
  def change
    create_table :wishlists do |t|
      t.timestamps
    end

    add_reference :wishlists, :user
    add_foreign_key :wishlists, :users

    create_join_table :wishlists, :albums
    add_foreign_key :albums_wishlists, :wishlists
    add_foreign_key :albums_wishlists, :albums
  end
end
