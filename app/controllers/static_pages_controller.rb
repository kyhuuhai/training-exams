class StaticPagesController < ApplicationController
  
  def home
    @exams = Exam.all
    @exam_cart = Examcart.all
  end
end
