		 	$(function () {
			    
		 		$("#guardar").tooltip();
		 		
		 		//fecha de alumno
		 		var fecha = document.getElementById('fecha1').value;		 		
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
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});
		 		
		 		//fecha de tutor		 		
		 		fecha = document.getElementById('fecha2').value;		 		
		 		prettyDate;
		 		
		 		if (fecha == 0){
		 		
		 			var myDate = new Date();
			 		
			 		prettyDate = ('0'+ myDate.getDate()).slice(-2) + '/' + (myDate.getMonth()+1) + '/' +
			 		myDate.getFullYear();
			 		
		 		}else{
		 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}		 		
		 				 		
		 		$("#datepicker2").val(prettyDate);
		 		
		 		$("#datepicker2").datepicker({		 			
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});
		 		
		 		//fecha de madre		 		
		 		fecha = document.getElementById('fecha3').value;		 		
		 		prettyDate;
		 		
		 		if (fecha == 0){
		 		
		 			var myDate = new Date();
			 		
			 		prettyDate = ('0'+ myDate.getDate()).slice(-2) + '/' + (myDate.getMonth()+1) + '/' +
			 		myDate.getFullYear();
			 		
		 		}else{
		 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}		 		
		 				 		
		 		$("#datepicker3").val(prettyDate);
		 		
		 		$("#datepicker3").datepicker({  	
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});
		 		
		 		//fecha de ingreso		 		
		 		fecha = document.getElementById('fecha4').value;		 		
		 		prettyDate;
		 		
		 		if (fecha == 0){
		 		
		 			var myDate = new Date();
			 		
			 		prettyDate = ('0'+ myDate.getDate()).slice(-2) + '/' + (myDate.getMonth()+1) + '/' +
			 		myDate.getFullYear();
			 		
		 		}else{
		 					 			
		 			prettyDate = fecha.substring(8) + "/" + fecha.substring(5,7) + "/" + fecha.substring(0,4);
		 			
		 		}		 		
		 				 		
		 		$("#datepicker4").val(prettyDate);
		 		
		 		$("#datepicker4").datepicker({
		 		   changeYear: true,
 		 		   changeMonth: true,
		 		   dateFormat: "dd/mm/yy"		 		   		 		   		 		   
		 		});


		});