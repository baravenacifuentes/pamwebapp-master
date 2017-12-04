class Sample < ApplicationRecord
	# States
	# 0 unspecified         --       green
	# 1 optimal     > min and < mid  green
	# 2 filter      > mid and < max  yellow
	# 3 additive    < min            red
	# 4 change      > max            red

	belongs_to :unit
	has_one :lubricant, through: :unit
	has_many :sample_variables

	before_save :update_state

	after_save :update_parents

	def update_state
		sample_variables.each do |sample_variable|
			self.state = sample_variable.state if self.state < sample_variable.state
			break if self.state == 4
		end
	end

	def update_parents
		unit.update_worst_sample(self)
	end

	def deadline
		taked_at + lubricant.max_hours.hours
	end

	def state_to_s
		case
		when state == 0
			"Sin calcular"
		when state == 1
			"El lubricante se encuentra en rangos óptimos"
		when state == 2
			"El lubricante debe ser sometido a filtración"
		when state == 3
			"Se debe agregar aditivo indicado por fabricante"
		when state == 4, deadline > Time.now
			"El lubricante debe ser remplazado"
		end
	end

	def next_sample_date
		"Se debe tomar la siguiente muestra antes del <em>#{I18n.l deadline.to_date, format: :long}</em> y quedan <em>#{(deadline.to_date - Date.today).to_i}</em> días para ello"
	end
	def state_class
		if state == 3 or state == 4 or Time.now > deadline
			['list-group-item list-group-item-danger', 'collapse show ']
		elsif state == 2 or Time.now > (deadline - 10.days)
			['list-group-item list-group-item-warning', 'collapse show ']
		else
			['list-group-item list-group-item-success collapsed', 'collapse ']
		end
	end

	def sample_variables_to_s
		result = ''
		sample_variables.includes(:variable, variable: :type).each do |sample_variable|
			result += "#{sample_variable.variable.type.name}: #{sample_variable.value} - "
		end
		result.sub(/ - $/, '')
	end

	# def update_state
	# 	current_state = state
	# 	deadline = taked_at + lubricant.max_hours.hours
	# 	comp = unit.component
	# 	gear = comp.gear
	# 	type = gear.type

	# 	unit.update_attributes current_state: current_state if unit.current_state < current_state
	# 	unit.update_attributes deadline: deadline if unit.deadline.nil? or unit.deadline > deadline

	# 	comp.update_attributes current_state: current_state if comp.current_state < current_state
	# 	comp.update_attributes deadline: deadline if comp.deadline.nil? or comp.deadline > deadline

	# 	gear.update_attributes current_state: current_state if gear.current_state < current_state
	# 	gear.update_attributes deadline: deadline if gear.deadline.nil? or gear.deadline > deadline

	# 	type.update_attributes current_state: current_state if type.current_state < current_state
	# 	type.update_attributes deadline: deadline if type.deadline.nil? or type.deadline > deadline
	# end

	# def state
	# 	current_state = nil
	# 	sample_variables.each do |s|
	# 		case s.value
	# 		when s.variable.min..s.variable.mid
	# 			current_state = 1
	# 		when s.variable.mid..s.variable.max
	# 			current_state = 2
	# 		when 0..s.variable.min
	# 			current_state = 3
	# 		else
	# 			return 4
	# 		end
	# 	end
	# 	current_state
	# end
end
