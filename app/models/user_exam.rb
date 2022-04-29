class UserExam < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  scope :order_by_name, ->{order :name}
  scope :search_exam, ->(name) { where('name LIKE ?', "%#{name}%") if name.present?}
end
