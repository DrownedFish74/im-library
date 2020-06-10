class ImpressionsController < ApplicationController
  def create
    @impression = Impression.create(impression_params)
    respond_to do |format|
      format.json
    end
  end
  private
  def impression_params
    params.require(:impression).permit(:comment).merge(user_id: current_user.id, book_id: params[:book_id])
  end
end
