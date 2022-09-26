class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :uuid, unique: true, nil: false
      t.string :content
      t.float :score
      t.integer :question_type_id, nil: true
      t.integer :lesson_id

      t.timestamps
    end
  end
end
