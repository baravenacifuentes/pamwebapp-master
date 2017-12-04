jQuery ->
	$('.form-control').bind 'focus keypress', ->
		$(this).closest('.form-group').removeClass('has-danger')

$(document).on 'turbolinks:load', ->
	$ ->
		$('[data-toggle="tooltip"]').tooltip()

	$('.chosen-select').chosen
		allow_single_deselect: true
		no_results_text: 'No results matched'
		placeholder_text_single: "None"
		width: '100%'
