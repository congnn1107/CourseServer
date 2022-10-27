class AddDefault0ToDurationForLessons < ActiveRecord::Migration[7.0]
  def change
    change_column_default :lessons, :duration, from: nil, to: 0
  end
end
