class SetNotNullToViewCountForLessons < ActiveRecord::Migration[7.0]
  def change
    change_column_null :lessons, :view_count, false, 0
  end
end
