$(document).ready(function(){

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

	$('#new-conference-validate').click(function(){
		//create table
		var dataConf = new Array();
		//var tcs = new Array();
		dataConf['new-id-ieee'] = $('#new-id-ieee').val();
		dataConf['new-title'] = $('#new-title').val();
		dataConf['new-adress'] = $('#new-adress').val();
		dataConf['new-description'] = $('#new-description').val();
		// for (var i = 0, tab.lenght; )
		dataConf['new-tcs'] = new Array();

		$('#wrap_tc input:checked').each(function(n){
			dataConf['new-tcs'][n] = $(this).attr('id');
		});

		console.log(dataConf);

		// émission des données de création de conf
	    socket.emit('create_conf', dataConf);
	  
	});

	
});