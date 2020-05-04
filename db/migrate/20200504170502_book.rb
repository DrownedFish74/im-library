class Book < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :ISBN, :string
  end
end
