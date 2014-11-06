		 	$(function () {
			    
		 		
		 		var fecha = document.getElementById('fecha').value;
		 		
		 		var prettyDate;
		 		
		 		if (fecha == 0){
		 		
		 			var myDate = new Date();
			 		
			 		prettyDate = ('0'+ myDate.getDate()).slice(-2) + '/' + (myDate.getMonth()+1) + '/' +
			 		myDate.getFullYear();
			 		
		 		}else{
		 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}
		 		
		 		$("#datepicker").val(prettyDate);
		 		
		 		$("#datepicker").datepicker({
  			 	   //yearRange: '2014:2014',
		 		   //defaultDate: '05/11/2014',
		 		   //changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy",		 		   
		// 		   showOn: "both",
		 		   buttonText: "Seleccionar Fecha",		 		   		 		   
		 		   beforeShowDay: $.datepicker.noWeekends,
		 		   minDate: '-10d',
		 	       maxDate: '+1m',
		 		});
		});