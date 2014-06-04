$(document).ready(function(){

	$('#task_file_upload').change(function(e) {
		$("#upload-file-info").html($(this).val());
		$('#wrap_upload_progress').show();

		var file = e.target.files[0];
		var stream = ss.createStream();

		// upload a file to the server.
		ss(socket).emit('file', stream, {name: file.name, size: file.size, conference_id: $('#conf-id').data('conference_id'), task_id:$('#task-modal-validate').data('task_id')});
		ss.createBlobReadStream(file).pipe(stream);

		var blobStream = ss.createBlobReadStream(file);
		var size = 0;

		blobStream.on('data', function(chunk) {
		  size += chunk.length;
		  var upload_progress = Math.floor(size / file.size * 100);
		  console.log(upload_progress+ '%');
		  $('#upload_progress').css('width', upload_progress+'%');

		  if(upload_progress == 100){
			setTimeout(function(){
				reset_upload_progress();
			}, 2000);
		  }
		});

		blobStream.pipe(stream);
	});


	function reset_upload_progress(){
		$('#wrap_upload_progress').hide();
		$('#upload_progress').attr('aria-valuenow', 0);
		$('#upload_progress').css('width', '0px');

		$('#upload-file-info').text('');
	}


	socket.on('file_upload', function(data) {
		if(data.response == "ok"){
			console.log("file uploaded");
			$('#task-modal-upload-input').hide();
			$('#task-modal-uploaded').show();
			$('#task_'+data.task_id).data('file_uploaded',1);
		} else {
			console.log("file not uploaded");
		}
	});
});