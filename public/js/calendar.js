$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	socket.emit('get_user_conferences', 1);
	
	socket.on('get_user_conferences', function(data){
    	console.log(data);
		for (var conferenceId in data.conferences){
    		$('#conf-list').append(
    			'<div class="conference-header accueil">'
					+'<div class="conference-header-left">'
						+'<h1>'+data.conferences[conferenceId].title+'</h1>'
						+'<h2><b>ID : </b>'+data.conferences[conferenceId].id_iee+'</h2>'
						+'<p><b>Lieu : </b>'+data.conferences[conferenceId].adress+'</p>'
						+'<p><b>Horaire : </b>From '+data.conferences[conferenceId].start.substr(0,10)+' to '+data.conferences[conferenceId].end.substr(0,10)+'</p>'
					+'</div>'
					+'<div class="conference-header-right">'
				            +'</div>'
				        +'</div>'
					+'</div>'
				+'</div>'
    		);
    	}
    });
	
	$('#calendar').fullCalendar({
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,basicWeek,basicDay'
		},
		editable: true,
		events: [
			{
				title: 'Conference Beaubourg',
				start: new Date(y, m, 1)
			},
			{
				title: 'Conference Australie',
				start: new Date(y, m, d-5),
				end: new Date(y, m, d-2)
			},
			{
				id: 999,
				title: 'Repeating Event',
				start: new Date(y, m, d-3, 16, 0),
				allDay: false
			},
			{
				id: 999,
				title: 'Repeating Event',
				start: new Date(y, m, d+4, 16, 0),
				allDay: false
			},
			{
				title: 'Meeting',
				start: new Date(y, m, d, 10, 30),
				allDay: false
			},
			{
				title: 'Lunch',
				start: new Date(y, m, d, 12, 0),
				end: new Date(y, m, d, 14, 0),
				allDay: false
			},
			{
				title: 'Birthday Party ',
				start: new Date(y, m, d+1, 19, 0),
				end: new Date(y, m, d+1, 22, 30),
				allDay: false
			},
			{
				title: 'Click for Google',
				start: new Date(y, m, 28),
				end: new Date(y, m, 29),
				url: 'http://google.com/'
			}
		]
	});
	
});