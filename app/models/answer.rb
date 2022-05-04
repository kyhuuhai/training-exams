class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, length: { maximum: Settings.model.question.content_length_max }
  validates :is_correct_answer, inclusion: { in: [true, false] }
  scope :order_by_content, -> { order :content }
  scope :order_by_id, -> { order :id }
end
