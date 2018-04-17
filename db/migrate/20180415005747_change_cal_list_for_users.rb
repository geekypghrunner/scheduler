class ChangeCalListForUsers < ActiveRecord::Migration[5.1]
  def change
      change_column :users, :cal_list, :text, array: true, default: nil
  end
end
