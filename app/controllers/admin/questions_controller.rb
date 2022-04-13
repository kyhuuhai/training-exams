class Admin::QuestionsController < ApplicationController
  before_action :load_exam, only: %i(create)
  def new
    @exam = Exam.find_by(id: params[:exam_id])
    @question = @exam.questions.new
  end

  def create
    @question = @exam.questions.new question_params
    if @question.save
      flash[:success] = "Thêm câu hỏi thành công"
      redirect_to admin_exam_path(@exam)
    else
      flash[:danger] = "Thêm câu hỏi thất bại"
      redirect_to admin_exam_path(@exam)
    end
  end

  private

  def question_params
    params.require(:question).permit :content
  end

   def load_exam
    @exam = Exam.find_by(id: params[:exam_id])
    return if @exam

    flash[:warning] = "Không tìm thấy bài thi"
    redirect_to root_path
  end
end
