class WishesController < ApplicationController
  def new
  end
  
  def create
    @wish = Wish.create(wish_create_params)
    case @wish.purpose
    when "friend"
      redirect_to friends_path
    when "borrow"
      redirect_to user_bookshelves_path(@wish.for_id)
    when "return"
      redirect_to user_bookshelves_path(current_user)
    end
  end
  
  def edit
    @user = User.find(current_user.id)
    @wish = Wish.find(params[:id])
    @books = @wish.books
    
  end
  
  def update
    wish = Wish.find(params[:id])
    case wish.purpose
    when "friend"
      if wish.update(wish_update_params)
        wish.reflection_friend if wish.status == "ok"
        redirect_to user_path(current_user),notice:"#{User.find(wish.from_id).nickname}さんと友達になりました。"
      else
        redirect_to user_path(current_user)
      end
    when "borrow"
      if wish.update(wish_update_params)
        wish.reflection_borrow_book
        redirect_to user_path(current_user),notice:"#{User.find(wish.from_id).nickname}さんに本を貸し出しました。"
      else
        redirect_to user_path(current_user), notice:"#{User.find(wish.from_id).nickname}さんに本を貸し出しませんでした。"
      end
    when "return"
      if wish.update(wish_update_params)
        if book_status == "open"
          wish.reflection_return_open
          redirect_to user_path(current_user),notice:"#{User.find(wish.from_id).nickname}さんから返ってきた本を開架にしまいました。"
        else
          wish.reflection_return_close
          redirect_to user_path(current_user),notice:"#{User.find(wish.from_id).nickname}さんから返ってきた本を書庫にしまいました。"
        end
      end
    end
  end
  
  private
  def wish_create_params
    params.require(:wish).permit(:purpose,:deadline,:for_id,:status,:comment,book_ids: []).merge(from_id:current_user.id)
  end
  
  def wish_update_params
    if params[:OK] != nil
      params.require(:wish).permit(:purpose,:deadline,book_ids:[]).merge(status:"ok")
    else
      params.require(:wish).permit(:purpose,:deadline,book_ids:[]).merge(status:"ng")
    end
  end
  
  def book_status
    params.require(:wish).permit(:bookshelf_status)
  end

  def wish_reply
    params.require(:wish).permit(:status)
  end
end