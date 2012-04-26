jQuery ->
	# Isotope
	container = $('#users')
	container.imagesLoaded ->
		container.isotope
		  itemSelector : '.user'
	
	# Infinite Scroll
	isScrolledIntoView = (elem) ->
		docViewTop = $(window).scrollTop()
		docViewBottom = docViewTop + $(window).height()
		elemTop = $(elem).offset().top
		elemBottom = elemTop + $(elem).height()
		(elemTop >= docViewTop) && (elemTop <= docViewBottom)

	if $('.pagination').length
	  $(window).scroll ->
	    url = $('.pagination .next_page a').attr('href')
	    if url && isScrolledIntoView('.pagination')
	      $('.pagination').text('Fetching more...')
	      $.getScript(url)
	  $(window).scroll()
	
	# Edit User Form
	$('#user_standing').live 'change', () ->
		if $('#user_standing').val() is '3'
			$('#alumni_fields').hide()
			$('#user_degree').val('6')
		else if $('#user_standing').val() is '4'
			$('#alumni_fields').show()
			$('#user_degree').val('8')
		else
			$('#alumni_fields').show()
			$('#user_degree').val('7')
		$('#user_degree').trigger('liszt:updated')