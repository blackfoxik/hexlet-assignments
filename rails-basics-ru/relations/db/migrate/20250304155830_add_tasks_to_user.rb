class AddTasksToUser < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :tasks, null: true, foreign_key: true
  end
end
