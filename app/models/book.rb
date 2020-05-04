class Book < ApplicationRecord
  belongs_to :user
  has_many :wish_books
  has_many :wishes, through: :wish_books
  has_many :impressions
end
