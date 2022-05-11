class CreateExamcarts < ActiveRecord::Migration[6.0]
  def change
    create_table :examcarts do |t|
      t.references :user, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
