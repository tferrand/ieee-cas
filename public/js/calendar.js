$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	socket.emit('get_user_conferences', 1);
	
	socket.on('get_user_conferences', function(data){
				test = [];

		for (var conferenceId in data.conferences){
    				

			
			test[conferenceId] = {
				title : data.conferences[conferenceId].title,
				start : data.conferences[conferenceId].start,
				end : data.conferences[conferenceId].end
			}
		
		}
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicWeek,basicDay'
			},
			editable: true,
			events: test

		});
			    	console.log(data);

    });
	
	
});