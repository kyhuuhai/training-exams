class User::ExamsController < ApplicationController
  before_action :load_exam, only: %i( show result_exam)

  def new
  end

  def index
    @exams = Exam.search_exam(params[:name]).order_by_name.paginate(page: params[:page], per_page: Settings.paginate.manage)
  end

  def edit
  end

  def show
    @questions = @exam.questions.order_by_content
    @answers = Answer.includes(:question).where(question_id: @questions.ids).order_by_content
  end

  private

  def exam_params
    params.require(:exam).permit :name, :pass_score, :time_limit
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:warning] = t "controller.admin.load_exam_fail"
    redirect_to admin_exams_path
  end
end
