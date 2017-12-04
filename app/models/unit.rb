class Unit < ApplicationRecord
	belongs_to :component
	belongs_to :lubricant
	belongs_to :worst_sample, optional: true, class_name: 'Sample'
	has_many :samples

	def has_children?
		false
	end

	def update_worst_sample(sample)
		self.update_attributes worst_sample: sample
		component.update_worst_sample
	end

	def to_s
		name
	end

	def long_to_s
		"#{name} - Muestras: <strong>#{samples.count}</strong> - Estado: <em>#{samples.any? ? samples.last.state_to_s : 'No se han tomado muestras aún'}</em>#{samples.any? ? " - #{samples.last.next_sample_date}" : ''}".html_safe
	end
end
