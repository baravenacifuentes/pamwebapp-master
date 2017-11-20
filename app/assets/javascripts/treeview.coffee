$ ->
	$('.list-group-item').on 'click', ->
		$('.fa-plus-square, .fa-minus-square', this).toggleClass('fa-plus-square fa-minus-square')
