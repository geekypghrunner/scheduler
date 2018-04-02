class ChangeDateToBeStringInWeeks < ActiveRecord::Migration[5.1]
  def change
    change_column :weeks, :start, :string
    change_column :weeks, :end, :string
    
  end
end
