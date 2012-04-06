class CreateProgrammingTestCases < ActiveRecord::Migration
  def change
    create_table :programming_test_cases do |t|
      t.integer :programming_task_id
      t.text :stdin
      t.text :stdout

      t.timestamps
    end
  end
end
