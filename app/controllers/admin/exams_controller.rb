class Admin::ExamsController < ApplicationController
  before_action :load_exam, only: %i(edit update destroy)

  def index
    @exams = Exam.exam_by_name.paginate(page: params[:page], per_page: Settings.paginate.manage)
  end

  def new
    @exam = Exam.new
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
