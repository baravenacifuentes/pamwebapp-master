module TreeviewHelper
	def treeview(children, class_name='', level=0, id_name=nil)
		class_name+= 'list-group'
		content_tag :div, class: class_name, id: id_name do
			children.each do |child|
				if child.has_children?
					if child.worst_sample.present?
						child_class_name, child_list_class_name = child.worst_sample.state_class
					else
						child_class_name = 'list-group-item list-group-item-success collapsed'
						child_list_class_name = 'collapse '
					end
					concat link_to("##{child.class.name.tableize.dasherize}-#{child.id}", class: child_class_name, data: { turbolinks: :false, toggle: :collapse }) {
						level.times do
							concat content_tag(:span, nil, class: 'indent')
						end
						concat icon('square', class: 'fa-fw')
						concat child.name
						concat child.worst_deadline_to_icon
					}
					concat treeview(child.children, child_list_class_name, level + 1, "#{child.class.name.tableize.dasherize}-#{child.id}")
				else
					child_class_name = child.worst_sample.present? ? child.worst_sample.state_class[0] : 'list-group-item list-group-item-success collapsed'
					concat link_to(child, class: child_class_name) {
						level.times do
							concat content_tag(:span, nil, class: 'indent')
						end
						concat child.worst_sample.deadline_to_icon
						concat child.long_to_s
					}
				end
			end
		end
	end
end
