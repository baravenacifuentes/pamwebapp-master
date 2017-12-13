class Gear < ApplicationRecord
	belongs_to :type, class_name: 'GearType'
	belongs_to :worst_sample, optional: true, class_name: 'Sample'
	has_many :components

	alias_attribute :children, :components
	has_methods :children

	def update_worst_sample
		components.each do |component|
			if component.worst_sample.present?
			self.worst_sample = component.worst_sample if self.worst_sample.nil? or self.worst_sample.state < component.worst_sample.state
		end
		end
		self.save
		type.update_worst_sample
	end
end
