class CreateWishBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :wish_books do |t|
      t.references :wish, null:false, foreign_key: true
      t.references :book, null:false, foreign_key: true
      t.timestamps
    end
  end
end
