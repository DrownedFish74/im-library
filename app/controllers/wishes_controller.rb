class WishesController < ApplicationController
  def new
  end
  
  def create
    @wish = Wish.create(wish_create_params)
    case @wish.purpose
    when "friend"
      redirect_to user_friends_path
    when "borrow"
      redirect_to "/users/#{@wish.for_id}/bookshelves"
    when "return"
      redirect_to user_bookshelves_path
    end
  end
  
  def edit
    @user = User.find(params[:user_id])
    @wish = Wish.find(params[:id])
    @books = @wish.books
    
  end
  
  def update
    wish = Wish.find(params[:id])
    case wish.purpose
    when "friend"
      if wish.update(wish_update_params)
        wish.reflection_friend if wish.status == "ok"
        redirect_to "/users/#{params[:user_id]}",notice:"#{User.find(wish.from_id).nickname}さんと友達になりました。"
      else
        redirect_to "/users/#{params[:user.id]}"
      end
    when "borrow"
      if wish.update(wish_update_params)
        wish.reflection_borrow_book
        redirect_to "/users/#{params[:user_id]}",notice:"#{User.find(wish.from_id).nickname}さんに本を貸し出しました。"
      else
        redirect_to "/users/#{params[:user_id]}", notice:"#{User.find(wish.from_id).nickname}さんに本を貸し出しませんでした。"
      end
    when "return"
      if wish.update(wish_update_params)
        if book_status == "open"
          wish.reflection_return_open
          redirect_to "/users/#{params[:user_id]}",notice:"#{User.find(wish.from_id).nickname}さんから返ってきた本を開架にしまいました。"
        else
          wish.reflection_return_close
          redirect_to "/users/#{params[:user_id]}",notice:"#{User.find(wish.from_id).nickname}さんから返ってきた本を書庫にしまいました。"
        end
      end
    end
  end
  
  private
  def wish_create_params
    params.require(:wish).permit(:purpose,:deadline,:for_id,:status,:comment,book_ids: []).merge(from_id:params[:user_id])
  end
  
  def wish_update_params
    params.require(:wish).permit(:purpose,:deadline,:status,book_ids:[])
  end
  
  def book_status
    params.require(:wish).permit(:bookshelf_status)
  end

  def wish_reply
    params.require(:wish).permit(:status)
  end
end