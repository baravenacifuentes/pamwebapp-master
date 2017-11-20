module ApplicationHelper
	def display_alert(content_or_options_with_block={}, options={}, &block)
		if block_given?
			options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
			message = capture(&block)
		else
			message = content_tag :p, sanitize(content_or_options_with_block, tags: %w())
		end

		html_class = options.has_key?(:class) ? options.fetch(:class) : 'alert-success'
		html_class += ' alert alert-dismissible fade show'
		html_class = html_class.split.sort.join(' ')

		if message.present?
			content_tag :div, class: html_class do
				content = content_tag :button, class: 'close', data: { dismiss: 'alert' } do
					icon 'close'
				end
				content += message
			end
		end
	end

	def title(title=nil, *args)
		content_for :title do
			if t('.title', default: '').present?
				"#{ t '.title', *args } | #{ t 'defaults.app_name_plain' }"
			elsif title.present?
				"#{ title } | #{ t 'defaults.app_name_plain' }"
			else
				t 'defaults.app_name_plain'
			end
		end
	end

	def header_generator(object, icon_name, heading=nil)
		buttons = []
		if object.present? and user_signed_in?
			case action_name.to_sym
			when :new
				heading ||= t('users.defaults.new', model: object.model_name.human)

				buttons << index_link_to(object, 'reply', 'btn btn-admin-panel-primary')
			when :show
				heading ||= object.respond_to?(:to_s) ? object.to_s : object.model_name.human

				buttons << index_link_to(object, 'reply', 'btn btn-admin-panel-primary')
				buttons << edit_link_to(object, 'edit', 'btn btn-admin-panel-warning')
				buttons << destroy_link_to(object, 'remove', 'btn btn-admin-panel-danger')
			when :edit
				heading ||= object.respond_to?(:to_s) ? t('users.defaults.edit_with_name', name: object.to_s) : t('users.defaults.edit', model: object.model_name.human)

				buttons << show_link_to(object, 'reply', 'btn btn-admin-panel-primary')
				buttons << destroy_link_to(object, 'remove', 'btn btn-admin-panel-danger')
			when :index
				heading ||= object.model_name.human.pluralize(I18n.locale)

				buttons << new_link_to(object, 'plus', 'btn btn-admin-panel-primary')
			end
		end

		title heading

		header_content = content_tag :h1 do
			concat icon icon_name
			concat heading
		end

		content_tag :div, class: 'admin-header' do
			content_tag :div, class: 'row-wg' do
				if buttons.any?
					concat content_tag(:div, class: 'col-9') {
						header_content
					}
					concat content_tag(:div, class: 'col-3') {
						content_tag :div, class: 'btn-group pull-right' do
							buttons.join.html_safe
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
			concat paginate_with_info(objects)
		end
	end

	def actions_generator(object)
		content = show_link_to(object, 'eye').to_s
		content += edit_link_to(object, 'edit', 'text-warning').to_s
		content += destroy_link_to(object, 'remove', 'text-danger').to_s
		content.html_safe
	end

	def new_link_to(object, icon_name, class_name=nil)
		path = case object
		when ->(x) { x == User }
			new_user_invitation_path
		else
			[:new, object.model_name.name.underscore]
		end
		if current_user.can? :create, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('users.defaults.new', model: object.model_name.human)} do
				icon icon_name
			end
		end
	end

	def show_link_to(object, icon_name, class_name=nil)
		path = object
		if current_user.can? :show, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('users.defaults.show', model: object.model_name.human)} do
				icon icon_name
			end
		elsif action_name != 'index'
			index_link_to object, icon_name, class_name
		end
	end

	def edit_link_to(object, icon_name, class_name=nil)
		path = case object
		when User
			edit_user_registration_path
		else
			[:edit, object]
		end
		if current_user.can? :update, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('users.defaults.edit', model: object.model_name.human)} do
				icon icon_name
			end
		end
	end

	def index_link_to(object, icon_name, class_name=nil)
		path = object.class
		if current_user.can? :index, object
			link_to path, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('users.defaults.back')} do
				icon icon_name
			end
		end
	end

	def destroy_link_to(object, icon_name, class_name=nil)
		path = object
		if current_user.can? :destroy, object
			link_to path, method: :delete, class: class_name, data: { toggle: 'tooltip', placement: 'bottom', title: t('users.defaults.remove', model: object.model_name.human), confirm: t('users.defaults.confirm_remove', model: object.model_name.human)} do
				icon icon_name
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

	def navbar_link_to_index(object, icon_name)
		if current_user.can? :index, object
			content_tag :li, class: 'nav-item' do
				if current_page?(object)
					content_tag :span, class: 'nav-link active' do
						concat icon icon_name
						concat object.model_name.human.pluralize(I18n.locale)
					end
				else
					link_to object, class: 'nav-link' do
						concat icon icon_name
						concat object.model_name.human.pluralize(I18n.locale)
					end
				end
			end
		end
	end

	def avatar_tag(source, options = {})
		options.merge!({onerror: "this.onerror=null;this.src='#{asset_path('avatar-unknown.jpg')}';"})
		image_tag source, options
	end

	def paginate_with_info(resources)
		content = paginate resources
		content += content_tag :h6, class: 'small text-muted text-center' do
			page_entries_info resources
		end
	end

	def treeview(children, class_name='', level=0, id_name=nil)
		class_name+= 'list-group'
		content_tag :div, class: class_name, id: id_name do
			children.each do |child|
				if child.has_children?
					concat link_to("##{child.class.name.tableize.dasherize}-#{child.id}", class: child.state_class, data: { turbolinks: :false, toggle: :collapse }) {
						level.times do
							concat content_tag(:span, nil, class: 'indent')
						end
						concat icon('plus-square', class: 'fa-fw')
						concat child.name
					}
					concat treeview(child.children, 'collapse ', level + 1, "#{child.class.name.tableize.dasherize}-#{child.id}")
				else
					concat link_to(child, class: child.state_class) {
						level.times do
							concat content_tag(:span, nil, class: 'indent')
						end
						concat icon('circle-o', class: 'fa-fw')
						concat child.name
					}
				end
			end
		end
	end
end
