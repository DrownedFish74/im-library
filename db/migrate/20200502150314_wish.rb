class Wish < ActiveRecord::Migration[5.2]
  def change
    add_column :wishes, :comment, :text
  end
end
