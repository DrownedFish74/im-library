class SorceryCore < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,            null: false
      t.string :password_digest
      t.string :name, null:false
      t.string :nickname, null:false
      t.string :salt
      t.timestamps                null: false
    end
    
    add_index :users, :email, unique: true
  end
end
