class AddLimitsToProgrammingTasks < ActiveRecord::Migration
  def change
    add_column :programming_tasks, :time_limit, :integer

    add_column :programming_tasks, :memory_limit, :integer

  end
end
