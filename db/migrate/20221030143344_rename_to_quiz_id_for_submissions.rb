class RenameToQuizIdForSubmissions < ActiveRecord::Migration[7.0]
  def change
    rename_column :submissions, :exam_id, :quiz_id
  end
end
