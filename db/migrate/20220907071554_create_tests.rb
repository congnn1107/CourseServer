class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :uuid, unique: true, nil: false
      t.integer :duration
      t.integer :course_id
      t.integer :lesson_id
      t.timestamps
    end
  end
end
