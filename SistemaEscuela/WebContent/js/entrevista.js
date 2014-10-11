$(function () {
    
	var mes = $('#mesbase').val();
		
	$('#mes option').each(function () {
		
		var val = $(this).val();
		
		if (val < mes){
			
			$(this).remove();
			
		}
	 
	});
	 
});