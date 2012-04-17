class ProgramResult < ActiveRecord::Base

	attr_accessible :programming_test_case_id, :status_code_id, :time, :memory, :log

	validates :programming_test_case_id, presence: true
	validates :status_code_id, presence: true

	belongs_to :program, inverse_of: :program_results
	belongs_to :programming_test_case
	belongs_to :status_code

end
