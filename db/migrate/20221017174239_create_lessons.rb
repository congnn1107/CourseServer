class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :uuid
      t.string :name
      t.string :description
      t.float :duration
      t.string :url
      t.integer :view_count
      t.integer :course_id
      t.timestamps
    end
  end
end
