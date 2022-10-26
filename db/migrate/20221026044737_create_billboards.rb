class CreateBillboards < ActiveRecord::Migration[7.0]
  def change
    create_table :billboards do |t|
      t.string :name
      t.string :title
      t.string :content
      t.string :image

      t.timestamps
    end
  end
end
