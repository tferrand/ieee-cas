$(document).ready(function(){
	$('#new-conference-validate').click(function(){
		alert('ok');
	})

	function needFix(field, error){
	   if(error == false){
			field.css("border","1px solid red");
		}
		else{
  	      	field.css("background-color","");
  	  	}
	}

	$('#new-id-ieee').blur(function(){
		if($(this).val().length == 8){
			needFix($(this),true);
			return false;
		}
		else{
			needFix($(this),false);
			return true;	
		}
	});
});