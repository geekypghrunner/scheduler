class AddCalendarListToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cal_list, :text, array:true, default: []
  end
end
