class BookshelvesController < ApplicationController
  def index #自分の本棚？
    @user = User.find(params[:user_id])
    @openBooks = Book.where("(user_id=?)",params[:user_id]).where("(status=?) or (status=?)","open","lending")
    @closeBooks = Book.where("(user_id=?)",params[:user_id]).where("(status=?)","close")
    @borrowingBooks = Book.where("(status=?) and (borrower_id=?)","lending",current_user.id)
  end


  def show
  end
end
