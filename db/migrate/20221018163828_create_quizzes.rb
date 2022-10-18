class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :uuid
      t.string :name
      t.string :description
      t.integer :time
      t.integer :course_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
