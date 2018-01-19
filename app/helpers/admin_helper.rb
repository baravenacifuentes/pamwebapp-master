module AdminHelper
	def header_generator(object, icon_name, heading=nil, buttons=nil)
		if object.present?
			case action_name.to_sym
			when :new, :create
				heading ||= t('admin_helper.new', model: object.singularize)
				buttons ||= buttons_generator(object, :index)
			when :show
				heading ||= object.respond_to?(:to_s) ? object.to_s : object.singularize
				buttons ||= buttons_generator(object, :index, :edit, :destroy)
			when :edit, :update
				heading ||= object.respond_to?(:to_s) ? t('admin_helper.edit_with_name', name: object.to_s) : t('admin_helper.edit', model: object.singularize)
				buttons ||= buttons_generator(object, :index, :show, :destroy)
			when :index
				heading ||= object.pluralize
				buttons ||= buttons_generator(object, :new)
			end
		end

		title heading

		heading_content = content_tag :h1 do
			concat icon icon_name
			concat heading
		end

		content_tag :div, class: 'admin-header' do
			content_tag :div, class: 'row-wg' do
				if buttons.present?
					concat content_tag :div, heading_content, class: 'col-9'
					concat content_tag(:div, class: 'col-3') {
						content_tag :div, class: 'btn-group pull-right' do
							buttons
						end
					}
				else
					heading_content
				end
			end
		end
	end

	def table_generator(objects, *args)
		args = objects.attrs | args
		content_tag :div, class: 'col-sm-12' do
			concat content_tag(:table, class: 'admin-table') {
				concat content_tag(:thead) {
					content_tag :tr do
						args.each do |attribute|
							case attribute
							when Hash
								concat content_tag :th, objects.attribute_name(attribute[:name]), class: attribute[:class]
							when :id, :actions, /.*\?/, /.*\_at/
								concat content_tag :th, objects.attribute_name(attribute), class: 'table-center'
							else
								concat content_tag :th, objects.attribute_name(attribute)
							end
						end
					end
				}
				concat content_tag(:tbody) {
					objects.each do |object|
						concat content_tag(:tr) {
							args.each do |attribute|
								case attribute
								when Hash
									concat content_tag(:td, nil, class: attribute[:class]){
										attribute[:content].present? ? attribute[:content] : object.send(attribute[:method])
									}
								when :id
									concat content_tag :td, object.send(attribute), class: 'table-center'
								when :actions
									concat content_tag :td, actions_generator(object), class: 'table-center'
								when /.*\?/
									concat content_tag(:td, class: 'table-center'){
										object.send(attribute) ? icon('check-square-o', class: 'text-success') : icon('square-o')
									}
								when /.*\_at/
									concat content_tag(:td, class: 'table-center'){
										distance_of_time_in_words Time.zone.now, object.send(attribute),
										true,
										highest_measures: 2,
										accumulate_on: :days if object.send(attribute).present?
									}
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
			concat paginate_with_info(objects) if objects.respond_to?(:total_pages)
		end
	end

	def dbox_generator(object, *args)
		args |= object.attrs
		content_tag :div, class: 'description-box-inverse' do
			content_tag :dl, class: 'row-wg' do
				args.each do |attribute|
					case attribute
					when /.*\?/
						concat content_tag :dt, object.attribute_name(attribute), class: 'col-sm-3'
						concat content_tag(:dd, class: 'col-sm-9'){
							object.send(attribute) ? icon('check-square-o', class: 'text-success') : icon('square-o')
						}
					else
						concat content_tag :dt, object.attribute_name(attribute), class: 'col-sm-3'
						concat content_tag :dd, object.send(attribute), class: 'col-sm-9'
					end
				end
			end
		end
	end

	def title(title=nil, *args)
		content_for :title do
			if t('.title', default: '').present?
				"#{ t '.title', *args } | #{ t 'globals.app_name_plain' }"
			elsif title.present?
				"#{ title } | #{ t 'globals.app_name_plain' }"
			else
				t 'globals.app_name_plain'
			end
		end
	end

	def buttons_generator(object, *args)
		args.map{ |arg| send "#{arg.to_s}_link_to", object, "btn btn-admin-#{arg.to_s}" }.join.html_safe
	end

	def actions_generator(object)
		content_tag :div do
			concat show_link_to(object)
			concat edit_link_to(object, 'text-warning')
			concat destroy_link_to(object, 'text-danger')
			concat accept_link_to(object, 'text-success')
		end
	end

	def index_link_to(object, class_name=nil)
		path = object.class
		if current_user.can? :index, object.class
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.back')} do
				icon 'index'
			end
		end
	end

	def show_link_to(object, class_name=nil)
		path = object
		if current_user.can? :show, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.show', model: object.singularize)} do
				icon 'show'
			end
		end
	end

	def new_link_to(object, class_name=nil)
		path = [:new, object.model_name.singular_route_key]
		if current_user.can? :new, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.new', model: object.singularize)} do
				icon 'new'
			end
		end
	end

	def edit_link_to(object, class_name=nil)
		path = [:edit, object]
		if current_user.can? :edit, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.edit', model: object.singularize)} do
				icon 'edit'
			end
		end
	end

	def destroy_link_to(object, class_name=nil)
		path = object
		if current_user.can? :destroy, object
			link_to path, method: :delete, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.remove', model: object.singularize), confirm: t('admin_helper.confirm_remove', model: object.singularize)} do
				icon 'destroy'
			end
		end
	end

	def accept_link_to(object, class_name=nil)
		if action_name.to_sym == :show and controller_name.to_sym == :courses
			path = accept_student_courses_path(course_id: params[:id], id: object.id)
			if current_user.can? :accept, object
				link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('admin_helper.accept', model: object.singularize)}, method: :post do
					icon 'accept'
				end
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
						concat object.pluralize
					end
				else
					link_to object, class: 'nav-link' + class_name do
						concat icon icon_name
						concat object.pluralize
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
					concat object.pluralize
				end
			else
				link_to object, class: 'dropdown-item' do
					concat icon icon_name
					concat object.pluralize
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
