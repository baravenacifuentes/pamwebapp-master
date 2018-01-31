class Component < ApplicationRecord
	belongs_to :gear
	belongs_to :worst_sample, optional: true, class_name: 'Sample'
	belongs_to :worst_sample_deadline, optional: true, class_name: 'Sample'
	has_many :units

	alias_attribute :children, :units
	has_methods :children

	validates_presence_of :name

	def update_worst_sample
		units.each do |unit|
			if unit.worst_sample.present?
				self.worst_sample = unit.worst_sample if self.worst_sample.nil? or self.worst_sample.state < unit.worst_sample.state or self.worst_sample.old?
				self.worst_sample_deadline = unit.worst_sample_deadline if self.worst_sample_deadline.nil? or self.worst_sample_deadline.deadline > unit.worst_sample_deadline.deadline or self.worst_sample_deadline.old?
			end
		end
		self.save
		gear.update_worst_sample
	end

	def worst_deadline_to_icon
		if worst_sample_deadline.present?
			if worst_sample_deadline.deadline < Time.now
				'<i class="fa fa-fw fa-clock-o text-danger"></i>'.html_safe
			elsif worst_sample_deadline.deadline - 10.days < Time.now
				'<i class="fa fa-fw fa-clock-o text-warning"></i>'.html_safe
			else
				'<i class="fa fa-fw fa-clock-o text-success"></i>'.html_safe
			end
		end
	end

	def to_s
		"#{gear.to_s} - #{name}"
	end
end
