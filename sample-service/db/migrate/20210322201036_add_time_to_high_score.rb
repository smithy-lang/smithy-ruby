class AddTimeToHighScore < ActiveRecord::Migration[6.1]
  def change
    add_column :high_scores, :time, :time
  end
end
