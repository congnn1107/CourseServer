class AddCategoryIdToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :category_id, :integer
  end
end
