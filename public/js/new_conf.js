$(document).ready(function(){
	$('#new-conference-validate').click(function(){

	})

	function needFix(field, error){
	   if(erreur){
			field.style.backgroundColor = "#fba";
		}
		else{
  	      	field.style.backgroundColor = "";
  	  	}
	}

	function verifID(field){
		if(field.value.length = 8){
			needFix(field,true);
			return false;
		}
		else{
			needFix(field,false);
			return true;	
		}
	}
});