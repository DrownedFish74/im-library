class Book < ApplicationRecord
  belongs_to :user
  has_many :wish_books
  has_many :wishes, through: :wish_books
  has_many :impressions

  def borrow_wishing_user
    wishes = self.wishes
  end
end
