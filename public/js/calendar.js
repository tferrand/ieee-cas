$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
		
	socket.on('get_user_conferences', function(data){
		console.log(data);

		conferencesData = [];

		for (var conferenceId in data.conferences){
			conferencesData[conferenceId] = {
				title : data.conferences[conferenceId].title,
				start : data.conferences[conferenceId].start,
				end : data.conferences[conferenceId].end,
				url: '/tferrand@isep.fr/conference/'+data.conferences[conferenceId].id_iee
			}
		}

		var date = new Date(data.conferences[0].start);
		var year1 = date.getFullYear();
		var month1 = date.getMonth();
		var day1 = date.getDate();
		
		$('#calendar').fullCalendar({
			year: year1,
			month: month1,
			date: day1,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicWeek'
			},
			editable: true,
			events: conferencesData
		});

		$('#calendar').hide();

    });


    //Show/Hide list/calendar view of conferences
    $('#show_list').click(function(){
    	$(this).siblings().removeClass('active');
    	$(this).addClass('active');
    	$('#conferences-wrap').show();
    	$('#calendar').hide();
    });
	
	$('#show_calendar').click(function(){
		$(this).siblings().removeClass('active');
		$(this).addClass('active');
    	$('#calendar').show();
    	$('#conferences-wrap').hide();
    });


	
});