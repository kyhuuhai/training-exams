class User::HistoryDoExamsController < ApplicationController
  before_action :load_exam, only: %i(create show)
  before_action :load_history, only: %i(show)

  def index
  end

  def create
    y = params[:length].to_i
    x = params[:data]
    counter = 0
    is_true = 0 # số câu đúng
    # số lần test của 1 exam
    max_amount = HistoryDoExam.max_amount_test
    if max_amount.present?
      max_amount += 1
    else
      max_amount = 0
    end
    while counter < y
      id = x["#{counter}"]["id"].to_i
      answer = x["#{counter}"]["answer"]
      question = Question.find_by id: id
      answer_content = question.answers.find_by(is_correct_answer: true, question_id: question.id).content
      # answer_content = Answer.check_answer(question.id)
      if answer_content === answer
        is_true += 1
      end
      counter += 1
      history1 = HistoryDoExam.create(answer: answer, user_id: current_user.id, question_id: id, amount_test: max_amount)
    end
    respond_to do |format|
      format.html { render user_exam_result_exam_path(id: @exam.id, is_true: is_true) }
      format.json{render json: {id: @exam.id, is_true: is_true, url: user_exam_history_do_exam_path(id: @exam.id, is_true: is_true, amount_test: max_amount)}}
    end
  end

  def show
    # @questions = @history_exams.map {|history| history.question}
    # @true_answers = Answer.includes(:questions).where(answers: {is_correct_answer: true}, question_id: @questions.map(&:id))
    # @answer_contents = @true_answers.map {|answer| answer.content}
    @is_true = params[:is_true].to_i
  end

  private

  def history_do_exams_params
    params.require(:history).permit :answer, :amount_test, :user_id, :question_id
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:warning] = t "controller.admin.load_exam_fail"
    redirect_to admin_exams_path
  end

  def load_history
    # @history_exam = HistoryDoExam.history_do_exam_by_amount_test(params[:amount_test].to_i)
    @history_exams = HistoryDoExam.includes(:user, :question).where(amount_test: params[:amount_test].to_i)
    return if @history_exams

    flash[:warning] = t "controller.admin.load_history_exam_fail"
    redirect_to admin_exams_path
  end
end
