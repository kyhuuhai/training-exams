class Admin::QuestionsController < ApplicationController
  before_action :load_exam, only: %i(new create edit update destroy)
  before_action :load_question, only: %i(edit update destroy)

  def new
    @question = @exam.questions.new
  end

  def create
    @question = @exam.questions.new question_params
    if @question.save
      flash[:success] = t "controller.admin.create_question_success"
      redirect_to admin_exam_path(@exam)
    else
      flash[:danger] = t "controller.admin.create_question_fail"
      redirect_to admin_exam_path(@exam)
    end
  end

  def edit
  end

  def update
    if @question.update question_params
      flash[:success] = t "controller.admin.update_question_success"
      redirect_to admin_exam_path(@exam)
    else
      flash[:danger] = t "controller.admin.update_question_fail"
      redirect_to admin_exam_path(@exam)
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "controller.admin.delete_question_success"
      redirect_to admin_exam_path(@exam)
    else
      flash[:danger] = t "controller.admin.delete_question_fail"
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

    flash[:warning] = t "controller.admin.load_exam_fail"
    redirect_to root_path
  end

  def load_question
    @question = Question.find_by(id: params[:id])
    return if @question.present?

    flash[:warning] = t "controller.admin.load_question_fail"
    redirect_to root_path
  end
end
