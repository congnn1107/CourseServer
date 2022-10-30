class AddLessonsLearnedToCourseSubscribes < ActiveRecord::Migration[7.0]
  def change
    add_column :course_subscribes, :lessons_learned, :string, default: "[]"
  end
end