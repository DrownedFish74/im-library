# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_04_022823) do

  create_table "books", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "status", null: false
    t.integer "borrower_id"
    t.date "return_deadline"
    t.string "publisher"
    t.string "author"
    t.string "ISBN"
    t.text "cover"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "friends", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "impressions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment"
    t.string "status"
    t.integer "user_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_impressions_on_book_id"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "name", null: false
    t.string "nickname", null: false
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wish_books", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "wish_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_wish_books_on_book_id"
    t.index ["wish_id"], name: "index_wish_books_on_wish_id"
  end

  create_table "wishes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "purpose"
    t.date "deadline"
    t.integer "from_id", null: false
    t.integer "for_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.text "comment"
    t.index ["for_id"], name: "index_wishes_on_for_id"
    t.index ["from_id"], name: "index_wishes_on_from_id"
  end

  add_foreign_key "books", "users"
  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "impressions", "books"
  add_foreign_key "impressions", "users"
  add_foreign_key "wish_books", "books"
  add_foreign_key "wish_books", "wishes"
  add_foreign_key "wishes", "users", column: "for_id"
  add_foreign_key "wishes", "users", column: "from_id"
end
