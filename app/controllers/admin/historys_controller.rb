class Admin::HistorysController < ApplicationController
before_action :correct_exam, only: [:index]
  def index
    @user_exams = @exam.user_exams.includes(:user) 
  end

  private

  def correct_exam
    @exam = Exam.find_by(id: params[:exam_id])
  end
end
