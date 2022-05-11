class AchievementsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @user_exams = @user.user_exams.includes(:exam) # fix N+1
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
