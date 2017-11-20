class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true

	def self.has_methods(*args)
		args.each do |arg|
			define_method "has_#{arg}?" do
				self.send(arg).any?
			end
		end
	end

	def state_class
		if current_state == 1 or current_state == 4 or (deadline.present? and deadline < Time.now)
			'list-group-item list-group-item-danger'
		elsif current_state == 3
			'list-group-item list-group-item-warning'
		else
			'list-group-item'
		end
	end
end
