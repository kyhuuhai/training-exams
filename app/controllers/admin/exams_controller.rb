class Admin::ExamsController < ApplicationController
  before_action :load_exam, only: %i(edit update destroy show)

  def index
    @exams = Exam.search(params[:name]).order_by_name.paginate(page: params[:page], per_page: Settings.paginate.manage)
  end

  def new
    @exam = Exam.new
  end

  def show
    @questions = Question.includes(:exam).where(exam_id: @exam.id).order_by_id
    @answers = Answer.includes(:question).where(question_id: @questions.ids).order_by_id
  end

  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t "controller.admin.create_exam_success"
      redirect_to admin_exams_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @exam.update exam_params
      flash[:success] = t "controller.admin.update_exam_success"
      redirect_to admin_exams_path
    else
      flash.now[:warning] = t "controller.admin.update_exam_fail"
      render :edit
    end
  end

  def destroy
    if @exam&.destroy
      flash[:success] = "Xóa thành công"
    else
      flash[:danger] = "Xóa thất bại"
    end
    redirect_to admin_exams_path
  end

  private

  def exam_params
    params.require(:exam).permit :name, :pass_score, :time_limit,
                                  image_attributes: [:id, :image_url, :imageable, :_destroy]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam.present?

    flash[:warning] = t "controller.admin.load_exam_fail"
    redirect_to admin_exams_path
  end
end
