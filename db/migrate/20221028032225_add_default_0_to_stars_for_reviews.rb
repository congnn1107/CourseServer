class AddDefault0ToStarsForReviews < ActiveRecord::Migration[7.0]
  def change
    change_column_default :reviews, :stars, from: nil, to:0
  end
end
