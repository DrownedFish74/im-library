class Wish < ApplicationRecord
  # belongs_to :user
  has_many :wish_books
  has_many :books,through: :wish_books
  
  def reflection_borrow_book
    self.book_ids.each do |book_id|
      book = Book.find(book_id)
      book.update(borrower_id: self.from_id,status: "lending",return_deadline: self.deadline)
    end
  end

  def reflection_return_open
    self.book_ids.each do |book_id|
      book = Book.find(book_id)
      book.update(borrower_id:"",status:"open",return_deadline:"")
    end
  end

  def reflection_return_close
    self.book_ids.each do |book_id|
      book = Book.find(book_id)
      book.update(borrower_id:"",status:"open",return_deadline:"")
    end
  end

  def reflection_friend
    @friend = Friend.create(user_id:self.for_id,friend_id:self.from_id)
  end

  def from_name
    from_user = User.find(self.from_id)
    from_user.name
  end
end
