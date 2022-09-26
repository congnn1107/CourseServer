class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.string :uuid, unique: true
      t.integer :user_id
      t.integer :test_id
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :expire_at
      
      t.timestamps
    end
  end
end
