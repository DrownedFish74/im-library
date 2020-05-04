class FriendsController < ApplicationController
  def index
    @users = User.all
    @wish = Wish.new
  end

  def show
  end
end
