class User::UserHistoryExamsController < ApplicationController
  def index
    @user_exams = UserExam.includes(:exam).where(user_id: current_user.id).order(created_at: :desc)
  end

  def show
  end
end
