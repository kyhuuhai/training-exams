class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, length: { maximum: Settings.model.question.content_length_max }
  validates :is_correct_answer, inclusion: {in: [true, false]}
  scope :order_by_content, ->{order :content}
  scope :order_by_id, ->{order :id}

  # def check_answer(question_id)
  #   answers = Answer.where(question_id: question_id)
  #   answers.each do |answer|
  #     if answer.is_correct_answer == true
  #       return answer.content
  #     end
  #   end
  # end
end
