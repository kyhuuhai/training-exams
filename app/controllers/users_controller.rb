class UsersController < ApplicationController
  before_action :correct_user,only: [:edit, :show, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "controller.user.flash_success"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
  
  def logged_in_user
    return if logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
