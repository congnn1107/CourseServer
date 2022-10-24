class AddCategoryIdToCourseCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :course_categories, :category_id, :integer
  end
end
