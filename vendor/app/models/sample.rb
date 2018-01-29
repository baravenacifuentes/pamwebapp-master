class Sample < ApplicationRecord
	# States
	# 0 unspecified         --       green
	# 1 optimal     > min and < mid  green
	# 2 filter      > mid and < max  yellow
	# 3 additive    < min            red
	# 4 change      > max            red

	require 'roo'

	belongs_to :unit
	has_one :lubricant, through: :unit
	has_many :sample_variables

	before_save :update_state

	after_save :update_parents

	validates_presence_of :sample_code, :lab_code, :taked_at, :received_at, :reported_at

	validates_uniqueness_of :sample_code

	attr_accessor :file
	before_validation :import, on: :create, if: -> { file.present? }

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

	def import
		spreadsheet = case File.extname self.file.original_filename
		when ".xls"
			Roo::Excel.new self.file.path
		when ".xlsx"
			Roo::Excelx.new self.file.path
		else
			self.errors[:file] << I18n.t("errors.messages.invalid_file_format", extension: File.extname(file.original_filename))
			return nil
		end
		sheet = spreadsheet.sheet(0)

		self.sample_code = sheet.cell 'B', 1
		self.lab_code = sheet.cell 'H', 1

		self.reported_at = sheet.cell('E', 1)
		check_date :reported_at

		self.taked_at    = sheet.cell('B', 3)
		check_date :taked_at

		self.received_at = sheet.cell('B', 4)
		check_date :received_at


		gear_type = GearType.find_by name: sheet.cell('B', 7)
		return if check_value gear_type, GearType.singularize
		gear      = gear_type.gears.find_by name: sheet.cell('D', 7)
		return if check_value gear, Gear.singularize
		component = gear.components.find_by name: sheet.cell('B', 8)
		return if check_value component, Component.singularize
		self.unit = component.units.find_by name: sheet.cell('D', 8)
		return if check_value self.unit, Unit.singularize
		lubricant = self.unit.lubricant.name if self.unit.lubricant.name == sheet.cell('B', 9)
		return if check_value lubricant, Lubricant.singularize

		self.sample_variables << SampleVariable.new(value: sheet.cell('B', 16), variable: self.lubricant.variables.find_by(type: VariableType.find_by(name: sheet.cell('B', 15))))
		self.sample_variables << SampleVariable.new(value: sheet.cell('C', 16), variable: self.lubricant.variables.find_by(type: VariableType.find_by(name: sheet.cell('C', 15))))
		self.sample_variables << SampleVariable.new(value: sheet.cell('D', 16), variable: self.lubricant.variables.find_by(type: VariableType.find_by(name: sheet.cell('D', 15))))
		self.sample_variables << SampleVariable.new(value: sheet.cell('E', 16), variable: self.lubricant.variables.find_by(type: VariableType.find_by(name: sheet.cell('E', 15))))
		self.sample_variables << SampleVariable.new(value: sheet.cell('F', 16), variable: self.lubricant.variables.find_by(type: VariableType.find_by(name: sheet.cell('F', 15))))
	end

	def check_date(field)
		unless self.send(field).is_a? Date
			self.errors[:file] << I18n.t("errors.messages.invalid_field_format", field: self.attribute_name(field))
		end
	end

	def check_value(field, field_name)
		unless field.present?
			self.errors[:file] << I18n.t("errors.messages.not_found", field: field_name)
			return true
		else
			return false
		end
	end

	def errors_to_s
		msg = String.new
		self.errors.full_messages.each do |m|
			msg += "<p>#{m}</p>"
		end
		msg.html_safe
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

	def to_s
		sample_code
	end

	def sample_variables_to_s
		result = ''
		sample_variables.includes(:variable, variable: :type).each do |sample_variable|
			result += "#{sample_variable.variable.type.name}: #{sample_variable.value} - "
		end
		result.sub(/ - $/, '')
	end
end
