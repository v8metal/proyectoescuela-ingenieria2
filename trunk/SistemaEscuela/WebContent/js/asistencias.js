		 	$(function () {
			    
		 		var año = document.getElementById('año').value;	 		
		 		var myDate = new Date();			 		
		 		var prettyDate = ('0'+ myDate.getDate()).slice(-2) + '/' + (myDate.getMonth()+1);
			 		
			 	//alert (prettyDate);
			 	
		 		var range = "'"+ año + ":" + año + "'";
		 		
		 		$("#datepicker").val(prettyDate);
		 		
		 		$("#datepicker").datepicker({  			 	   
		 		   //defaultDate: '05/11/2014',
		 		   //changeYear: true,
  			 	   yearRange: ""+range,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm",		 		   
		// 		   showOn: "both",
		 		   buttonText: "Seleccionar Fecha",		 		   		 		   
		 		   beforeShowDay: $.datepicker.noWeekends,
		 		   //minDate: '-10d',
		 	       //maxDate: '+1m',
		 		});
		});