class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      # t.string :uuid
      t.string :content
      t.integer :stars
      t.integer :coursess_id
      t.integer :user_id
    end
  end
end
