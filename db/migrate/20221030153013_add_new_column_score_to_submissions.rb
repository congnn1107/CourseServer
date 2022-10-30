class AddNewColumnScoreToSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_column :submissions, :score, :int, default:0
  end
end
