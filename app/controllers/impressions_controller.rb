class ImpressionsController < ApplicationController
  # def create
  #   impression = Impression.create(impression_params)
  #   redirect_to "/users/#{params[:user_id]}/books/#{params[:book_id]}"
  # end
  def create
    @impression = Impression.create(impression_params)
    respond_to do |format|
      format.html { redirect_to "/users/#{params[:user_id]}/books/#{params[:book_id]}"}
      format.json
    end
  end
  private
  def impression_params
    params.require(:impression).permit(:comment).merge(user_id: params[:user_id], book_id: params[:book_id])
  end
end
