		 	$(function () {
			    
		 		$("#datepicker").datepicker({
		 		   dateFormat: "dd/mm/yy",
		 		   //defaultDate: '05/11/2014',
		 		   showOn: "both",
		 		   buttonText: "Pick a date",
		 		   //yearRange: '2014:2014',
		 		   //changeMonth: true, para poder selecionar el mes desde un dropdown		 		   
		 		   beforeShowDay: $.datepicker.noWeekends,
		 		   minDate:'0',
		 	       maxDate: '+3m',   //add this
		 		});		 					
		});