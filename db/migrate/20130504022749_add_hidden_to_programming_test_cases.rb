class AddHiddenToProgrammingTestCases < ActiveRecord::Migration
  def change
    add_column :programming_test_cases, :hidden, :boolean
  end
end
