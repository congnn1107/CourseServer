class CreateSubmissionDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :submission_details do |t|
      t.integer :submission_id
      t.integer :question_id
      t.integer :question_position
      
      t.timestamps
    end
  end
end
