		 	$(function () {
			    		 		
		 		var fecha = document.getElementById('fecha').value;
		 		var min = document.getElementById('min').value;
		 		var max = document.getElementById('max').value;
		 		
		 		var prettyDate;
		 		
		 		if (fecha == 0){
		 		
		 			var myDate = new Date();
			 		
			 		prettyDate = ('0'+ myDate.getDate()).slice(-2) + '/' + (myDate.getMonth()+1) + '/' + myDate.getFullYear();
			 		
		 		}else{
		 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}
		 		
		 		var range = "'"+ min + ":" + max + "'";
		 		
		 		$("#datepicker").val(prettyDate);
		 		
		 		$("#datepicker").datepicker({
		 			   yearRange: ""+range,
			 		   changeYear: true,
	 		 		   changeMonth: true,	 		 		   
			 		   dateFormat: "dd/mm/yy",		 		   		 		   
			 		   beforeShowDay: $.datepicker.noWeekends
			 	});
		});