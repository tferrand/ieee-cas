$(document).ready(function(){

	$('#new-conference-validate').click(function(){
		/*var tcOk = verifTC();
		var idOk = verifID($('#new-id-ieee'));
		var titleOk= verifTitle($('#new-title'));
		var acronymOk = verifAcronym($('#new-acronym'));
		var adressOk = verifAdress($('#new-adress-geocodify-input'));
		var descriptionOk = verifDescription($('#new-description'));
				 
		if(tcOk && idOk && titleOk && acronymOk)
		   return true;
		else if(tcOk == false && idOk && titleOk && acronymOk && adressOk && descriptionOk){
			alert("Vous n'avez pas selectionné assez de Technical Committees.")
			return false;
		}
		else
		{
		   alert("Veuillez remplir correctement tous les champs.");
		   return false;
		}*/
		verifDates();
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


	//Verification of dates
	function verifDates(){
		var start_date = $('new-start-date').value;
		var end_date = $('new-end-date').val();
	    
	    if (start_date.toISOString() == "") {
	        alert('gj')
	    } else {
	        alert(start_date.toISOString())
	    	}
	    }


	//Verification of adress
	$('#new-adress-geocodify-input').blur(function(){
		verifAdress($(this));
	});
	function verifAdress(field){
		if(field.val().length > 0){
			needFix(field,true);
			return true;
		}
		else{
			needFix(field,false);
			return false;	
		}
	}


	//Verification of description
	$('#new-description').blur(function(){
		verifDescription($(this));
	});

	function verifDescription(field){
		if(field.val().length > 0){
			needFix(field,true);
			return true;
		}
		else{
			needFix(field,false);
			return false;	
		}
	}


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

 	
 	$('#new-conference-validate').click(function(){
		//create table
		// var dataConf = [];
		// //var tcs = new Array();
		// dataConf['new_id_ieee'] = $('#new-id-ieee').val();
		// dataConf['new_title'] = $('#new-title').val();
		// dataConf['new_adress'] = $('#new-adress-geocodify-input').val();
		// dataConf['new_description'] = $('#new-description').val();
		// // for (var i = 0, tab.lenght; )
		// dataConf['new_tcs'] = [];

		// $('#wrap_tc input:checked').each(function(n){
		// 	dataConf['new_tcs'][n] = $(this).attr('id');
		// });

 		var datatcs = {};
		$('#wrap_tc input:checked').each(function(n){
			datatcs[n] = $(this).attr('id');
		});
		console.log(datatcs);

 		var dataConf = {
 			new_id_ieee : $('#new-id-ieee').val(),
 			new_title : $('#new-title').val(),
 			new_adress : $('#new-adress-geocodify-input').val(),
 			new_description : $('#new-description').val(),
 			new_tcs : datatcs
 		};
 		console.log(dataConf);

		//test = JSON.stringify({"new_id_ieee":"heho"});
		//test = JSON.stringify(dataConf);
		//console.log(test);
		// émission des données de création de conf
	    socket.emit('create_conf',  dataConf);
	  
	});
	

	
});