class AddCompilerAndExecutionToProgrammingLanguage < ActiveRecord::Migration
  def change
    add_column :programming_languages, :compiler, :string
    add_column :programming_languages, :execution, :string
  end
end
