class Add0ToIsDoneForUserLessons < ActiveRecord::Migration[7.0]
  def change
    change_column_default :user_lessons,:is_done,from: nil,to: 0
  end
end
