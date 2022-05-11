class ExamcartsController < ApplicationController
  skip_before_action:verify_authenticity_token
  before_action :correct_user, only: [:selecting, :destroy]
    
  def show_select
    @exam_carts = Examcart.all
  end

  def selecting
    @exam_carts = @user.examcarts.includes(:exam) 
    @title= "selecting"
    @users= @user.selecting.paginate(page: params[:page])
    render 'show_select'
  end
                      
  def create
    other_exam = Exam.find_by(id: params[:exam_id])
    @rel= Examcart.new(user_id: session[:user_id],
                                exam_id: other_exam.id)
                                @rel.save
                                redirect_to(root_url)
  end
 
  def destroy
    @exam = Examcart.find_by(id: params[:id]).exam
    current_user.unselect(@exam)
    redirect_to(root_url)
  end
end
