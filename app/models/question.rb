class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :exam

  validates :content, presence: true, length: { maximum: Settings.model.question.content_length_max }
  scope :order_by_content, -> { order :content }
  scope :order_by_id, -> { order :id }
end
