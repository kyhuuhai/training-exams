class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :show]
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find params[:id]
    if @user
      @user_exams = @user.user_exams.includes(:exam) # fix N+1
    else
      flash[:danger] = "User not found"
      redirect_to root_url
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in(@user)
      flash[:success] = t "controller.user.flash_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :address,
                                 :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
