class SetNotNullToDurationForLessons < ActiveRecord::Migration[7.0]
  def change
    change_column_null :lessons, :duration, false, 0
  end
end
