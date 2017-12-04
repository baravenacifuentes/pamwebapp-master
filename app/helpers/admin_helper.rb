module AdminHelper
	def header_generator(object, icon_name, heading=nil)
		if object.present? and user_signed_in?
			case action_name.to_sym
			when :new, :create
				heading ||= t('admin_helper.new', model: object.model_name.human)
				buttons = buttons_generator(object, :index)
			when :show
				heading ||= object.respond_to?(:to_s) ? object.to_s : object.model_name.human
				buttons = buttons_generator(object, :index, :edit, :destroy)
			when :edit, :update
				heading ||= object.respond_to?(:to_s) ? t('admin_helper.edit_with_name', name: object.to_s) : t('admin_helper.edit', model: object.model_name.human)
				buttons = buttons_generator(object, :index, :show, :destroy)
			when :index
				heading ||= object.model_name.human.pluralize(I18n.locale)
				buttons = buttons_generator(object, :new)
			end
		end

		title heading

		header_content = content_tag :h1 do
			concat icon icon_name
			concat heading
		end

		content_tag :div, class: 'admin-header' do
			content_tag :div, class: 'row-wg' do
				if buttons.present?
					concat content_tag(:div, class: 'col-9') {
						header_content
					}
					concat content_tag(:div, class: 'col-3') {
						content_tag :div, class: 'btn-group pull-right' do
							buttons.html_safe
						end
					}
				else
					header_content
				end
			end
		end
	end

	def admin_table_generator(objects, *attributes)
		content_tag :div, class: 'col-sm-12' do
			concat content_tag(:table, class: 'admin-table') {
				concat content_tag(:thead) {
					content_tag :tr do
						attributes.each do |attribute|
							case attribute
							when Array
								concat content_tag :th, objects.model.human_attribute_name(attribute.first), class: attribute.second
							when :id, :actions, /.*\?/
								concat content_tag :th, objects.model.human_attribute_name(attribute), class: 'table-center'
							else
								concat content_tag :th, objects.model.human_attribute_name(attribute)
							end
						end
					end
				}
				concat content_tag(:tbody) {
					objects.each do |object|
						concat content_tag(:tr) {
							attributes.each do |attribute|
								case attribute
								when Array
									concat content_tag :td, object.send(attribute.first), class: attribute.second
								when :id
									concat content_tag :td, object.send(attribute), class: 'table-center'
								when :actions
									concat content_tag :td, actions_generator(object), class: 'table-center'
								when /.*\?/
									concat content_tag(:td, class: 'table-center'){
										object.send(attribute) ? icon('check-square-o', class: 'text-success') : icon('square-o')
									}
								when /.*_at/
									concat content_tag :td, I18n.l(object.send(attribute).to_date, format: :long)
								when :color
									concat content_tag(:td, object.send(attribute), class: 'table-center'){
										content_tag :div, style: "background-color:#{object.send(attribute)};width=100%;" do
											object.send(attribute)
										end
									}
								else
									concat content_tag :td, object.send(attribute)
								end
							end
						}
					end
				}
			}
			# concat paginate_with_info(objects)
		end
	end

	def buttons_generator(object, *args)
		buttons = ''
		args.each do |arg|
			buttons += send("#{arg.to_s}_link_to", object, "btn btn-admin-#{arg.to_s}").to_s
		end
		buttons
	end

	def actions_generator(object)
		content = show_link_to(object).to_s
		content += edit_link_to(object, 'text-warning').to_s
		content += destroy_link_to(object, 'text-danger').to_s
		content.html_safe
	end

	def new_link_to(object, class_name=nil)
		path = case object.new
		when User
			new_user_invitation_path
		else
			[:new, object.model_name.singular]
		end
		if current_user.can? :create, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.new', model: object.model_name.human)} do
				icon 'new'
			end
		end
	end

	def show_link_to(object, class_name=nil)
		path = object
		if current_user.can? :show, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.show', model: object.model_name.human)} do
				icon 'show'
			end
		end
	end

	def edit_link_to(object, class_name=nil)
		path = case object
		when User
			edit_user_registration_path
		else
			[:edit, object]
		end
		if current_user.can? :update, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.edit', model: object.model_name.human)} do
				icon 'edit'
			end
		end
	end

	def index_link_to(object, class_name=nil)
		path = case object
		when Unit
			root_path
		else
			object.class
		end
		if current_user.can? :index, object.class
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.back')} do
				icon 'index'
			end
		end
	end

	def destroy_link_to(object, class_name=nil)
		path = object
		if current_user.can? :destroy, object
			link_to path, method: :delete, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.remove', model: object.model_name.human), confirm: t('admin_helper.confirm_remove', model: object.model_name.human)} do
				icon 'destroy'
			end
		end
	end

	def navbar_link_to(path, options={}, &block)
		content_tag :li, class: 'nav-item' do
			if current_page?(path)
				content_tag :span, options.merge({class: options[:class] += ' active'}) do
					capture(&block)
				end
			else
				link_to path, options do
					capture(&block)
				end
			end
		end
	end

	def navbar_link_to_index(object, icon_name, class_name=nil)
		class_name = class_name.nil? ? "" : " #{class_name}"
		if current_user.can? :index, object
			content_tag :li, class: 'nav-item' do
				if current_page?(object)
					content_tag :span, class: 'nav-link active' + class_name do
						concat icon icon_name
						concat object.model_name.human.pluralize(I18n.locale)
					end
				else
					link_to object, class: 'nav-link' + class_name do
						concat icon icon_name
						concat object.model_name.human.pluralize(I18n.locale)
					end
				end
			end
		end
	end

	def navbar_dropdown_link_to_index(object, icon_name)
		if current_user.can? :index, object
			if current_page?(object)
				content_tag :span, class: 'dropdown-item active' do
					concat icon icon_name
					concat object.model_name.human.pluralize(I18n.locale)
				end
			else
				link_to object, class: 'dropdown-item' do
					concat icon icon_name
					concat object.model_name.human.pluralize(I18n.locale)
				end
			end
		end
	end


	def paginate_with_info(resources)
		content = paginate resources
		content += content_tag :h6, class: 'small text-muted text-center' do
			page_entries_info resources
		end
	end
end
