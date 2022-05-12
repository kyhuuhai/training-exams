class Admin::UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :load_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 7)
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to admin_users_url
    end
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user.present?

    flash[:danger] = "khong tim thay user"
    redirect_to root_url
  end
end
