$(document).ready(function(){
	jQuery('#new-start-date, #new-end-date').datetimepicker({
		format:'Y/m/d H:i',
  		lang:'en'
	});


	//New conference modal
	$('#new-conference-modal').modal({
	  keyboard: false,
	  show: false
	});

	//Click on new conference button
	$(".new-conference-btn").click(function(){
		if($(this).data('model') == 'from_model'){
			socket.emit('get_user_conf_models', $('#user_id').data('user_id'));
			$('#new-inputs').hide();
			$('#conf_models').show();
			$('#new-conference-validate').hide();
		} else {
			$('#conf_models').hide();
			$('#new-inputs').show();
			$('#new-conference-validate').show();
		}
		$("#new-conference-modal").modal("show");
	});

	//when we receive user conferences models
	socket.on('get_user_conf_models', function(data){
		$('#conf_models_select').html('');
		$('#conf_models_select').append('<option value=""></option>');
		for (var position in data.conf_models){
			$('#conf_models_select').append('<option data-title="'+data.conf_models[position].title+'" data-acronym="'+data.conf_models[position].acronym+'" data-adress="'+data.conf_models[position].adress+'" data-description="'+data.conf_models[position].description+'" data-model_id="'+data.conf_models[position].model_id+'">'+data.conf_models[position].title+' ('+data.conf_models[position].acronym+')</option>')
		}
	});


	$('#conf_models_select').on('change', function() {
		$('#new-title').val($(this).find(':selected').data('title'));
		$('#new-acronym').val($(this).find(':selected').data('acronym'));
		$('#new-adress-geocodify-input').val($(this).find(':selected').data('adress'));
		$('#new-description').val($(this).find(':selected').data('description'));

		// $('#conf_models').hide();
		$('#new-inputs').show();
		$('#new-conference-validate').show();
	});

	//geocodify
	$("#new-adress-geocodify").geocodify({
        onSelect: function (result) { 
        	//alert(result); 
        }
    });
	$('#new-adress-geocodify input').removeClass('geocodifyInput');
    $('#new-adress-geocodify input').addClass('form-control');


    //Click on validate create conference
	$('#new-conference-validate').click(function(){
		var tcOk = verifTC();
		var idOk = verifID($('#new-id-ieee'));
		var titleOk= verifTitle($('#new-title'));
		var acronymOk = verifAcronym($('#new-acronym'));
		var startDateOk = verifEmptyDate($('#new-start-date'));
		var endDateOk = verifEmptyDate($('#new-end-date'));
		var comparingDatesOk = comparingDates();
		var adressOk = verifAdress($('#new-adress-geocodify-input'));
		var descriptionOk = verifDescription($('#new-description'));
		
				 
		if(tcOk && idOk && titleOk && acronymOk && startDateOk && endDateOk && comparingDatesOk && adressOk && descriptionOk){

			var datatcs = [];

			$('#wrap_tc input:checked').each(function(n){
				datatcs.push($(this).val());
			});
			console.log(datatcs);

	 		var dataConf = {
	 			user_id : $('#user_id').data('user_id'),
	 			model_id : 1,
	 			// model_id : $('#new-model').val(),
	 			new_id_ieee : $('#new-id-ieee').val(),
	 			new_title : $('#new-title').val(),
	 			new_acronym : $('#new-acronym').val(),
	 			new_adress : $('#new-adress-geocodify-input').val(),
	 			new_description : $('#new-description').val(),
	 			new_start : $('#new-start-date').val(),
	 			new_end : $('#new-end-date').val(),
	 			new_tcs : datatcs
	 		};
	 		console.log(dataConf);
		    socket.emit('create_conf',  dataConf);
		    
		} else if(tcOk == false && idOk && titleOk && acronymOk && startDateOk && endDateOk && comparingDatesOk &&  adressOk && descriptionOk){
			alert("You didn't select enough Technical Committees.")
			return false;
		} 
		else {
		   alert("Fill in all the fields correctly.");
		   return false;
		}
		comparingDates();
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
		if(field.val().length <= 150 && field.val().length>=4){
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


	//Verification of starting and ending date
	$('#new-start-date, #new-end-date').blur(function(){
		verifEmptyDate($(this));
		comparingDates();
	});
	function verifEmptyDate(field){
		var date = field.val();

	    if (date == "") {
	        needFix(field,false);
			return false;
	    } else {
	   		needFix(field,true);
			return true;	
	   	}
	}

	//Compare dates
	function getDate() {
	    var now     = new Date(); 
	    var year    = now.getFullYear();
	    var month   = now.getMonth()+1; 
	    var day     = now.getDate();
 
	    if(month.toString().length == 1) {
	        var month = '0'+month;
	    }
	    if(day.toString().length == 1) {
	        var day = '0'+day;
	    }   
	    var date = year+'-'+month+'-'+day;   
	    return date;
	}

	function str_to_date(str){
		var dt = new Date(str);
		return dt;
	}

	function calc_days(date1, date2){
		var distance = str_to_date(date1).getTime() - str_to_date(date2).getTime();
		distance = Math.ceil(distance / 1000 / 60 / 60 / 24);
		return distance;
	}

	function comparingDates(){
		var start_date = $('#new-start-date').val();
		var end_date = $('#new-end-date').val();

		var dist = calc_days(start_date.substr(0,10), getDate());
		console.log(start_date.substr(0,10));

		if (new Date(end_date) < new Date(start_date) && dist > 180) {
			alert('Wrong date order.');
			needFix($('#new-start-date'), false);
			needFix($('#new-end-date'), false);
			return false;
		} else if (new Date(end_date) < new Date(start_date) && dist < 180) {
			alert('Time is too short between now and the starting date, and the date are in the wrong order.');
			needFix($('#new-start-date'), false);
			needFix($('#new-end-date'), false);
			return false;
		} else if (new Date(end_date) > new Date(start_date) &&  dist < 180){
			alert('Time is too short between now and the starting date.');
			needFix($('#new-start-date'), false);
			needFix($('#new-end-date'), false);
			return false;
		} else if (new Date(end_date) > new Date(start_date) &&  dist > 180){
			needFix($('#new-start-date'), true);
			needFix($('#new-end-date'), true);
			return true;
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
		if(countingTC >= 3){
			return true;
		}
		else{
			return false;
		}
	}

	socket.on('create_conf_ok', function(){
		location.reload();
	});
 	
 // 	$('#new-conference-validate').click(function(){
	// 	//create table
	// 	// var dataConf = [];
	// 	// //var tcs = new Array();
	// 	// dataConf['new_id_ieee'] = $('#new-id-ieee').val();
	// 	// dataConf['new_title'] = $('#new-title').val();
	// 	// dataConf['new_adress'] = $('#new-adress-geocodify-input').val();
	// 	// dataConf['new_description'] = $('#new-description').val();
	// 	// // for (var i = 0, tab.lenght; )
	// 	// dataConf['new_tcs'] = [];

	// 	// $('#wrap_tc input:checked').each(function(n){
	// 	// 	dataConf['new_tcs'][n] = $(this).attr('id');
	// 	// });

 // 		var datatcs = {};
	// 	$('#wrap_tc input:checked').each(function(n){
	// 		datatcs[n] = $(this).attr('id');
	// 	});
	// 	console.log(datatcs);

 // 		var dataConf = {
 // 			new_id_ieee : $('#new-id-ieee').val(),
 // 			new_title : $('#new-title').val(),
 // 			new_adress : $('#new-adress-geocodify-input').val(),
 // 			new_description : $('#new-description').val(),
 // 			new_tcs : datatcs
 // 		};
 // 		console.log(dataConf);

	// 	//test = JSON.stringify({"new_id_ieee":"heho"});
	// 	//test = JSON.stringify(dataConf);
	// 	//console.log(test);
	// 	// émission des données de création de conf
	//     socket.emit('create_conf',  dataConf);
	  
	// });
	

	
});