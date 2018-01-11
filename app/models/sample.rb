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
		case state
		when 0
			I18n.t :unspecified, scope: [:samples, :states]
		when 1
			I18n.t :optimal, scope: [:samples, :states]
		when 2
			I18n.t :filter, scope: [:samples, :states]
		when 3
			I18n.t :additive, scope: [:samples, :states]
		when 4
			I18n.t :change, scope: [:samples, :states]
		end
	end

	def deadline_to_icon
		if deadline < Time.now
			'<i class="fa fa-fw fa-clock-o text-danger"></i>'.html_safe
		elsif deadline - 10.days < Time.now
			'<i class="fa fa-fw fa-clock-o text-warning"></i>'.html_safe
		else
			'<i class="fa fa-fw fa-clock-o text-success"></i>'.html_safe
		end
	end

	def next_sample_date
		if (deadline.to_date - Date.today).to_i >= 0
			I18n.t :next_sample_date, scope: :samples, deadline: I18n.l(deadline.to_date, format: :long), time_left: (deadline.to_date - Date.today).to_i
		else
			I18n.t :next_sample_date_expired, scope: :samples, deadline: I18n.l(deadline.to_date, format: :long), time_left: (Date.today - deadline.to_date ).to_i
		end
	end

	def state_class
		case state
		when 4, 3
			['list-group-item list-group-item-danger', 'collapse show ']
		when 2
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
end
