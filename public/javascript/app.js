$(function() {
	$('#search-form').submit(function(){
		var action = $('#dropdown').val();
		$('#search-form').attr("action", action);
	});

	$(document).ready(function() {
		$('#content').fadeIn(2000);
	});
});