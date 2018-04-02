class AddColumnsToWeeks < ActiveRecord::Migration[5.1]
  def change
    add_column :weeks, :prior_week, :string
    add_column :weeks, :following_week, :string
  end
end
