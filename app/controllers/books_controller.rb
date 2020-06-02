class BooksController < ApplicationController
require "date"
before_action :set_user
  def index
    return nil if params[:bookids] == ""
    @books = Book.where(id:params[:bookids])
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def show #本の詳細
    @book = Book.find(params[:id])
    @impressions = @book.impressions.includes(:user)
    @impression = Impression.new
  end
  
  def new #本の登録
    @book = Book.new
  end
  
  def create #本の登録
    @book = Book.create(book_params)
    redirect_to :new_book
  end
  
  
  def edit
  end
  
  def destroy
  end
  
  def search
  end
  
  private
  def book_params
    params.require(:book).permit(:ISBN,:title, :publisher, :author,:cover, :description,:status).merge(user_id:current_user.id)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
