class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title, null:false
      t.string :status, null:false
      t.integer :borrower_id
      t.date :return_deadline
      t.string :publisher
      t.string :author
      t.integer :ISBN
      t.text :cover
      t.text :description
      t.references :user, null:false, foreign_key: true
      t.timestamps
    end
  end
end 
