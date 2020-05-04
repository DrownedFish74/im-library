class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    return nil if params[:keyword] == ""
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @wishes = Wish.where("(for_id=?) or (from_id=?)",@user.id,@user.id).where(status:"wait")
  end

  def new
    logout
    @user = User.new
  end
  
  # GET /users/1/edit
  def edit
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.create(user_params)
    
    if @user.save
      user = login(params[:user][:email], params[:user][:password])
      redirect_to controller:"users",action:"show",id:user.id
    else
      render :new
    end
    
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :nickname, :salt)
  end
end
