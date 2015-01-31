class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User " + @user.first_name + " " + @user.last_name + " created."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "User " + @user.first_name + " " + @user.last_name + " updated."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
     @user = user.find(params[:id])
     @user.destroy
     flash[:success] = "User " + @user.first_name + " " + @user.last_name + " removed."
     redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :user_role_code, :council_id, :first_name, :last_name, :contact_phone)
    end
end
