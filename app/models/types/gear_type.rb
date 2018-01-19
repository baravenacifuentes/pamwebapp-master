class GearType < Type
	has_many :gears, foreign_key: 'type_id'
	belongs_to :worst_sample, optional: true, class_name: 'Sample'

	alias_attribute :children, :gears
	has_methods :children

	def update_worst_sample
		gears.each do |gear|
			if gear.worst_sample.present?
				self.worst_sample = gear.worst_sample if self.worst_sample.nil? or self.worst_sample.state < gear.worst_sample.state
				self.worst_deadline = gear.worst_deadline if self.worst_deadline.nil? or self.worst_deadline > gear.worst_deadline
			end
		end
		self.save
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
