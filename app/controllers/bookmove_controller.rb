class BookmoveController < ApplicationController
  def create
    if params[:OK] != nil
      books = Book.where(id: movebook_ids[:book_ids])
      books.update(movebook_status)
      redirect_to user_bookshelves_path(current_user)
    else
      redirect_to user_bookshelves_path(current_user)
    end
  end
  private
  def movebook_ids
    params.require(:bookshelf).permit(book_ids:[])
  end
  def movebook_status
    params.permit(:status)
  end
end
