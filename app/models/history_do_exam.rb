class HistoryDoExam < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :answer, presence: true
  scope :max_amount_test, ->{maximum :amount_test}
  scope :history_do_exam_by_amount_test, ->(amount_test){where amount_test: amount_test}
end
