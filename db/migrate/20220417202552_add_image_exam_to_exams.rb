class AddImageExamToExams < ActiveRecord::Migration[6.0]
  def change
    add_column :exams, :image_exam, :string
  end
end
