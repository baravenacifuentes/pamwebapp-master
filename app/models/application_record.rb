class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true

	def self.has_methods(*args)
		args.each do |arg|
			define_method "has_#{arg}?" do
				self.send(arg).any?
			end
		end
	end

	# plural names
	def self.pluralize
		model_name.human.pluralize(I18n.locale)
	end

	def pluralize
		self.class.pluralize
	end

	# singular names
	def self.singularize
		model_name.human
	end

	def singularize
		self.class.singularize
	end

	# get attribute name from any instance
	def self.attribute_name(attribute)
		human_attribute_name attribute
	end

	def attribute_name(attribute)
		self.class.attribute_name attribute
	end

	# define common attributes for tables and description boxes
	def self.attrs
		defined?(@attrs) ? @attrs : attribute_names.map(&:to_sym)
	end

	def attrs
		self.class.attrs
	end

	private
	def self.set_attrs(*args)
		instance_variable_set('@attrs', args)
	end
end
