class CreateWishes < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|
      t.string :purpose
      t.datetime :deadline
      t.references :from, null:false, foreign_key: { to_table: :users }
      t.references :for, null:false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
