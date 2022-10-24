class CreateCourseSubscribes < ActiveRecord::Migration[7.0]
  def change
    create_table :course_subscribes do |t|
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end
  end
end
