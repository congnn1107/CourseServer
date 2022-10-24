class CreateCourseCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :course_categories do |t|
      t.integer :course_id

      t.timestamps
    end
  end
end
