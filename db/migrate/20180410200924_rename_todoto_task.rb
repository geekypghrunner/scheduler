class RenameTodotoTask < ActiveRecord::Migration[5.1]
  def change
        rename_column :tasks, :todo_type, :task_type
  end
end
