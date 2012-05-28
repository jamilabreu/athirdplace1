jQuery ->
	$('abbr.timeago').timeago();
	$('#post_body').live 'focus', () ->
		$('#post_body').css({height: '48px'});
		$('#post_post_type_ids_chzn, #post-submit, .new-post-close, .new-post-bottom').show();
	
	$('#post_body').live 'focus keydown keyup', () ->
		$('.new-post-counter').html(140 - $('#post_body').val().length)
		
		if !$.trim($('#post_body').val())
			$('#post-submit').prop('disabled', true);
		else
			$('#post-submit').prop('disabled', false);
		
		if $(this).val().length > 140
			$('.new-post-counter').css({color: '#FF0000'});
			$('#post-submit').prop('disabled', true);
		else
			$('.new-post-counter').css({color: '#999'});
			$('#post-submit').prop('disabled', false);