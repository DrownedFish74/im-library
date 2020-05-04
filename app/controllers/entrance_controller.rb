class EntranceController < ApplicationController
  def index #トップページ
    @user = User.new
  end
end
