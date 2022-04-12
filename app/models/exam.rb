class Exam < ApplicationRecord
  has_many :user_exams, dependent: :destroy
  has_many :exam_questions
  has_many :questions, through: :exam_questions

  validates :name, presence: true,
                   length: { maximum: Settings.model.user.name_length_max }
  validates :pass_score,  numericality: {only_integer: true,
                                   greater_than_or_equal_to: 10,
                                   less_than_or_equal_to: 100},
                          presence: true
  validates :time_limit, presence: true

  scope :exam_by_name, ->{order :name}

  def add_question question
    questions << question
  end

  def remove_question question
    questions.delete question
  end
end
