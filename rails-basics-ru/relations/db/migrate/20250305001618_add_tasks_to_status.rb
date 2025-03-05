class AddTasksToStatus < ActiveRecord::Migration[7.2]
  def change
    add_reference :statuses, :tasks, null: true, foreign_key: true
  end
end
