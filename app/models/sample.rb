class Sample < ApplicationRecord
	# States
	# 0 unspecified
	# 1 additive < min
	# 2 normal < mid and > min
	# 3 alert < max and > mid
	# 4 change > max

	belongs_to :unit
	belongs_to :lubricant
	has_many :sample_variables


	def update_state
		current_state = state
		deadline = Time.now + lubricant.max_days.days
		comp = unit.component
		gear = comp.gear
		type = gear.type

		unit.update_attributes current_state: current_state if unit.current_state < current_state
		unit.update_attributes deadline: deadline if unit.deadline.nil? or unit.deadline > deadline

		comp.update_attributes current_state: current_state if comp.current_state < current_state
		comp.update_attributes deadline: deadline if comp.deadline.nil? or comp.deadline > deadline

		gear.update_attributes current_state: current_state if gear.current_state < current_state
		gear.update_attributes deadline: deadline if gear.deadline.nil? or gear.deadline > deadline

		type.update_attributes current_state: current_state if type.current_state < current_state
		type.update_attributes deadline: deadline if type.deadline.nil? or type.deadline > deadline
	end

	def state
		current_state = nil
		sample_variables.each do |s|
			case s.value
			when 0..s.variable.min
				1
			when s.variable.min..s.variable.mid
				2
			when s.variable.mid..s.variable.max
				3
			else
				return 4
			end
		end
		current_state
	end
end
