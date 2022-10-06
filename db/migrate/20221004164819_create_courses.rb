class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :uuid
      t.string :name
      t.string :description
      t.string :cover_url
      t.integer :status, default: 0
      t.integer :is_publish
      t.datetime :published_at
      t.timestamps
    end
  end
end
