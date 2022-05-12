class AddComlumnToUserExams < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_exams, :completed_time
    add_column :user_exams, :completed_time, :string
  end
end
