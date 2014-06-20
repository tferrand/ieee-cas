$(document).ready(function(){
	//Edit conference modal
	$('#edit-conference-modal').modal({
	  keyboard: false,
	  show: false
	});

	//geocodify
	$("#edit-adress-geocodify").geocodify({
        onSelect: function (result) { 
        	//alert(result); 
        }
    });
	$('#edit-adress-geocodify input').removeClass('geocodifyInput');
    $('#edit-adress-geocodify input').addClass('form-control');



	$('#edit_conf').click(function(){
		$('#edit-conference-modal').modal('show');
	});


	$('#edit-conference-validate').click(function(){
		var editTitleOk = verifTitle($('#edit-title'));
		var editAcronymOk = verifAcronym($('#edit-acronym'));
		var editAdressOk = verifAdress($('#edit-adress-geocodify-input'));
		var editDescriptionOk = verifDescription($('#edit-description'));

		if(editTitleOk && editAcronymOk && editAdressOk && editDescriptionOk){
			var dataEdit = {
	 			edit_title : $('#edit-title').val(),
	 			edit_acronym : $('#edit-acronym').val(),
	 			edit_adress : $('#edit-adress-geocodify-input').val(),
	 			edit_description : $('#edit-description').val(),
	 		};

			socket.emit('edit_conference', $('#conf-id').data('conference_id'), dataEdit);
		} else {
			alert("Fill in all the fields correctly.");
		}

	});


	$('#edit-title').blur(function(){
		verifTitle($(this));
	});

	$('#edit-acronym').blur(function(){
		verifAcronym($(this))
	});

	$('#edit-adress-geocodify-input').blur(function(){
		verifAdress($(this));
	});

	$('#edit-description').blur(function(){
		verifDescription($(this));
	});



	socket.on('edit_conference', function(data){
		if(data.response == 'ok'){
			location.reload();
		} else {
			alert('The conference has not been edited');
		}
	});

});