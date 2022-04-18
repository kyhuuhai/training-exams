class User::ResultExamsController < ApplicationController
  # before_action :load_exam, only: %i( show  result_exam)

  def create
    y = params[:length].to_i
    x = params[:data]
    counter = 0
    is_true = 0 # số câu đúng
    # exam = Exam.find_by id: params[:id]
    # byebug
    while counter < y do
      id = x["#{counter}"]["id"].to_i
      answer = x["#{counter}"]["answer"]
      question = Question.find_by id: id
      answer_content = question.answers.find_by(is_correct_answer: true, question_id: question.id).content
      # answer_content = Answer.check_answer(question.id)
      if answer_content === answer
        is_true += 1
      end
      counter += 1
    end
    # for i in 1..y  do
    #   z+= x["#{i}"]
    # end
  end

  private

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:warning] = t "controller.admin.load_exam_fail"
    redirect_to admin_exams_path
  end
end