class AddDeadlineToProgrammingTasks < ActiveRecord::Migration
  def change
    add_column :programming_tasks, :deadline, :timestamp
  end
end
