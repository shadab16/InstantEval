class RenameSourceToSourceCodeInPrograms < ActiveRecord::Migration
	def change
		rename_column :programs, :source, :source_code
	end
end
