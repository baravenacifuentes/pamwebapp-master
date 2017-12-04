class SampleVariable < ApplicationRecord
	belongs_to :sample
	belongs_to :variable, optional: true

	before_validation :update_state

	def update_state
		self.state = case value
		when variable.min..variable.mid
			1
		when variable.mid..variable.max
			2
		when 0..variable.min
			3
		else
			4
		end
	end
end
