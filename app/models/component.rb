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
			end
		end
		self.save
		gear.update_worst_sample
	end

	def to_s
		name
	end
end
