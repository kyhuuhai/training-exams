class Admin::StatisticsController < ApplicationController
  def index
    @exams = Exam.all
  end
end
