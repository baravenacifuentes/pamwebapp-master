class Gear < ApplicationRecord
	belongs_to :type, class_name: 'GearType'
	belongs_to :worst_sample, optional: true, class_name: 'Sample'
	belongs_to :worst_sample_deadline, optional: true, class_name: 'Sample'
	has_many :components

	alias_attribute :children, :components
	has_methods :children

	validates_presence_of :name

	def update_worst_sample
		components.each do |component|
			if component.worst_sample.present?
				self.worst_sample = component.worst_sample if self.worst_sample.nil? or self.worst_sample.state < component.worst_sample.state or self.worst_sample.old?
				self.worst_sample_deadline = component.worst_sample_deadline if self.worst_sample_deadline.nil? or self.worst_sample_deadline.deadline > component.worst_sample_deadline.deadline or self.worst_sample_deadline.old?
			end
		end
		self.save
		type.update_worst_sample
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
		"#{type.to_s} - #{name}"
	end
end
