class BookmoveController < ApplicationController
  def create
    Book.where(id: movebook_ids).update_all(status: movebook_status)
    redirect_to controller:"bookshelves", action:"index"
  end
  private
  def movebook_ids
    return params[:bookshelf][:book_ids]
  end
  def movebook_status
    return params[:status]
  end
end
