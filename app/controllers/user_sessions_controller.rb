class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to "/users/#{current_user.id}"
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_path
  end

  private
  def logout_id
    params[:id]
  end
  def login_params
    params.permit
  end

end
