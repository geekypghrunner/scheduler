class ChangeColumnForUsers < ActiveRecord::Migration[5.1]
  def change
      change_column :users, :cal_list, :text, array: true
  end
end
