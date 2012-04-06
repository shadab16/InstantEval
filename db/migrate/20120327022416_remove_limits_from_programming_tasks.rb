class RemoveLimitsFromProgrammingTasks < ActiveRecord::Migration
  def up
    remove_column :programming_tasks, :limits
  end

  def down
    add_column :programming_tasks, :limits, :string
  end
end
