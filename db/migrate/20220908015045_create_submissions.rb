class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.string :uuid, unique: true
      t.integer :exam_id
      t.integer :user_id

      t.timestamps
    end
  end
end
