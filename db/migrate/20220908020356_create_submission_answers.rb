class CreateSubmissionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :submission_answers do |t|
      t.integer :submission_detail_id
      t.integer :question_id
      t.integer :answer_id
      t.integer :input_answer_id

      t.timestamps
    end
  end
end
