class Program < ActiveRecord::Base

	attr_accessible :source_code, :programming_language_id, :programming_task_id

	validates :source_code, presence: true
	validates :programming_task_id, presence: true
	validates :programming_language_id, presence: true
	validates :user_id, presence: true

	validate :submission_is_before_deadline

	belongs_to :user
	belongs_to :programming_language
	belongs_to :programming_task
	belongs_to :status_code
	has_many :program_results, dependent: :destroy

	accepts_nested_attributes_for :program_results

	private
	def submission_is_before_deadline
		if programming_task.deadline.present? and Time.now > programming_task.deadline
			errors.add(:source_code, 'submission deadline is over')
		end
	end

end
