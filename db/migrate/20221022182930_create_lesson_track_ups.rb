class CreateLessonTrackUps < ActiveRecord::Migration[7.0]
  def change
    create_table :lesson_track_ups do |t|
      t.integer :course_subscribe_id
      t.integer :is_done
      t.integer :is_current

      t.timestamps
    end
  end
end
