class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.integer :is_publish
      t.datetime :published_at
      t.timestamps
    end
  end
end
