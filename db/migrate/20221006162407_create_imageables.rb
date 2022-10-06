class CreateImageables < ActiveRecord::Migration[7.0]
  def change
    create_table :imageables do |t|
      t.integer :target_id
      t.string :target_type
      t.timestamps
    end
  end
end
