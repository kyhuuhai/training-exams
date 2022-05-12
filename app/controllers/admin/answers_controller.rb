class Admin::AnswersController < ApplicationController
  before_action :load_resources, except: %i(show)
  before_action :load_answer, only: %i(edit update destroy)

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new answer_params
    if @answer.save
      flash[:success] = t "controller.admin.create_answer_success"
      redirect_to admin_exam_path(@exam)
    else
      flash[:danger] = t "controller.admin.create_answer_fail"
      redirect_to admin_exam_path(@exam)
    end
  end

  def edit
  end

  def update
    if @answer.update answer_params
      flash[:success] = t "controller.admin.update_answer_success"
      redirect_to admin_exam_path(@exam)
    else
      flash[:danger] = t "controller.admin.update_answer_fail"
      redirect_to admin_exam_path(@exam)
    end
  end

  def destroy
    if @answer.destroy
      flash[:success] = t "controller.admin.delete_answer_success"
    else
      flash[:danger] = t "controller.admin.delete_answer_fail"
    end
    redirect_to admin_exam_path(@exam)
  end

  private

  def answer_params
    params.require(:answer).permit :content, :is_correct_answer
  end

  def load_resources
    @exam = Exam.find_by(id: params[:exam_id])
    @question = Question.find_by(id: params[:question_id])
    return if @exam && @question

    flash[:warning] = t "controller.admin.load_resources_fail"
    redirect_to root_path
  end

  def load_answer
    @answer = Answer.find_by(id: params[:id])
    return if @answer.present?

    flash[:warning] = t "controller.admin.load_answer_fail"
    redirect_to root_path
  end
end
