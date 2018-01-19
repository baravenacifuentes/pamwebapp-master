class Component < ApplicationRecord
	belongs_to :gear
	belongs_to :worst_sample, optional: true, class_name: 'Sample'
	has_many :units

	alias_attribute :children, :units
	has_methods :children

	def update_worst_sample
		units.each do |unit|
			if unit.worst_sample.present?
				self.worst_sample = unit.worst_sample if self.worst_sample.nil? or self.worst_sample.state < unit.worst_sample.state
				self.worst_deadline = unit.worst_sample.deadline if self.worst_deadline.nil? or self.worst_deadline > unit.worst_sample.deadline
			end
		end
		self.save
		gear.update_worst_sample
	end

	def worst_deadline_to_icon
		if worst_deadline < Time.now
			'<i class="fa fa-fw fa-clock-o text-danger"></i>'.html_safe
		elsif worst_deadline - 10.days < Time.now
			'<i class="fa fa-fw fa-clock-o text-warning"></i>'.html_safe
		else
			'<i class="fa fa-fw fa-clock-o text-success"></i>'.html_safe
		end
	end

	def to_s
		name
	end
end
