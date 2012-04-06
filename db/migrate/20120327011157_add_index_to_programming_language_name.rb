class AddIndexToProgrammingLanguageName < ActiveRecord::Migration
	def change
		add_index :programming_languages, :name, unique: true
	end
end
