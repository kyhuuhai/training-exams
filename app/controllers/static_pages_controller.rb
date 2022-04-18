class StaticPagesController < ApplicationController
  def home
    @exams = Exam.all
  end
end
