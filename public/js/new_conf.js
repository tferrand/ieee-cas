$(document).ready(function(){
	var countingTC = 0;

	$('#new-conference-validate').click(function(){
		var tcOk = verifTC();
		var idOk = verifID($('#new-id-ieee'));
		var titleOk= verifTitle($('#new-title'));
		var acronymOk = verifAcronym($('#new-acronym'));
				 
		if(tcOk && idOk && titleOk && acronymOk)
		   return true;
		else
		{
		   alert("Veuillez remplir correctement tous les champs");
		   return false;
		}
	});

	function needFix(field, error){
	   if(error == false){
			field.css("border","1px solid red");
		}
		else{
			field.css("border","1px solid #ccc");
		}
	}


	//Verification of ID
	$('#new-id-ieee').blur(function(){
		verifID($(this));
	});

	function verifID(field){
		if(field.val().length == 8){
			needFix(field,true);
			return true;
		}
		else{
			needFix(field,false);
			return false;	
		}
	}


	//Verification of title
	$('#new-title').blur(function(){
		verifTitle($(this));
	});

	function verifTitle(field){
		if(field.val().length <= 45 && field.val().length>=4){
			needFix(field,true);
			return true;
		}
		else{
			needFix(field,false);
			return false;	
		}
	};


	//Verification of acronym
	$('#new-acronym').blur(function(){
		verifAcronym($(this))
	});

	function verifAcronym(field){
		if(field.val().length <= 12 && field.val().length>=1){ //need to check acronym.length with Amara
			needFix(field,true);
			return true;
		}
		else{
			needFix(field,false);
			return false;	
		}
	};	


	//Verification checkbox TC
	function verifTC(){
		countingTC = $( "input:checked" ).length;
		console.log(countingTC);
		if(countingTC >= 3){
			return true;
		}
		else{
			return false;
		}
	}


});