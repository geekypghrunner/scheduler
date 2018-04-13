class AddTodoTypeToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :todo_type, :string
  end
end
