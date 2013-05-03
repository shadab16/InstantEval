class AddIconToProgrammingLanguage < ActiveRecord::Migration
  def change
    add_column :programming_languages, :icon, :string
  end
end
