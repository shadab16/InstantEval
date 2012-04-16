class Program < ActiveRecord::Base

	attr_accessible :source_code, :programming_language_id, :programming_task_id

	validates :source_code, presence: true
	validates :programming_task_id, presence: true
	validates :programming_language_id, presence: true

	belongs_to :programming_language
	belongs_to :programming_task
	belongs_to :user
	belongs_to :status_code
	has_many :program_results, dependent: :destroy

end
