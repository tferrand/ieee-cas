$(document).ready(function(){
	

    var location_url = $(location).attr('href');

    if(location_url.indexOf("conference") >= 0){
    	socket.emit('get_conference', $("#conf-id").data('conference_id_ieee'));
    
    } else if(location_url.indexOf("sponsor") >= 0){
    	socket.emit('get_conference_to_sponsor', $("#conf-id").data('conference_id_ieee'));
    } else {
    	socket.emit('get_user_conferences', $('#user_id').data('user_id'),$('#user_type').data('user_type'));
    }


    //Quand on recoit les conferences de l'utilisateur
    socket.on('get_user_conferences', function(data){
    	for (var conferenceId in data.conferences){
    		$('#conferences-wrap').append(
    			'<div class="conference-header accueil">'
					+'<div class="conference-header-left">'
						+'<h1>'+data.conferences[conferenceId].title+' ('+data.conferences[conferenceId].acronym+')</h1>'
						+'<h2><b>ID : </b>'+data.conferences[conferenceId].id_iee+'</h2>'
						+'<p><b>Lieu : </b>'+data.conferences[conferenceId].adress+'</p>'
						+'<p><b>Horaire : </b>From '+data.conferences[conferenceId].start+' to '+data.conferences[conferenceId].end+'</p>'
					+'</div>'
					+'<div class="conference-header-right">'
						+'<h3>Progression :</h3>'
						+'<div class="progress progress-striped">'
				            +'<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="'+data.conferences[conferenceId].progression+'" aria-valuemin="0" aria-valuemax="100" style="width: '+data.conferences[conferenceId].progression+'%">'
				                +'<span class="sr-only">'+data.conferences[conferenceId].progression+'% Complete</span>'
				            +'</div>'
				            +'<span class="progress-completed">'+data.conferences[conferenceId].progression+'%</span>'
				        +'</div>'
						+'<button type="button" class="btn btn-info" style="width:100%;"><span class="glyphicon glyphicon-arrow-right"></span><a href="'+$('#user_login').data('user_login')+'/conference/'+data.conferences[conferenceId].id_iee+'">See the red wire</a></button>'
					+'</div>'
				+'</div>'
    		);
    	}
    });

    //Quand on recoit les conferences de l'utilisateur
    socket.on('get_conference_to_sponsor', function(data){
        		$('#conferences-wrap').append(
    			'<div class="conference-header accueil">'
					+'<div class="conference-header-left">'
						+'<h1>'+data.conferences[0].title+' ('+data.conferences[0].acronym+')</h1>'
						+'<h2><b>ID : </b>'+data.conferences[0].id_iee+'</h2>'
						+'<p><b>Lieu : </b>'+data.conferences[0].adress+'</p>'
						+'<p><b>Horaire : </b>From '+data.conferences[0].start+' to '+data.conferences[0].end+'</p>'
					+'</div>'
					+'<div class="conference-header-right">'
						+'<h3>Progression :</h3>'
						+'<div class="progress progress-striped">'
				            +'<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="'+data.conferences[0].progression+'" aria-valuemin="0" aria-valuemax="100" style="width: '+data.conferences[0].progression+'%">'
				                +'<span class="sr-only">'+data.conferences[0].progression+'% Complete</span>'
				            +'</div>'
				            +'<span class="progress-completed">'+data.conferences[0].progression+'%</span>'
				        +'</div>'
						+'<button type="button" class="btn btn-info" style="width:100%;"><span class="glyphicon glyphicon-arrow-right"></span><a href="../'+$('#user_login').data('user_login')+'/conference/'+data.conferences[0].id_iee+'">See the red wire</a></button>'
					+'</div>'
				+'</div>'
				+'<div class="conference-header accueil">'
					+'<div class="conference-header-right">'
						+'<button type="button" class="btn btn-success" style="width:100%;margin-bottom:8px;"><a style="color:white;text-decoration:none;" href="../sponsoranswer/'+data.conferences[0].id_iee+'/1">Sponsor it</a></button>'
						+'<button type="button" class="btn btn-danger" style="width:100%;"><a style="color:white;text-decoration:none;" href="../sponsoranswer/'+data.conferences[0].id_iee+'/0">Decline</a></button>'
					+'</div>'
				+'</div>'
    		);
    	
    });

	$model_id='';
    //Quand on recoit les infos d'une conference pour le fil rouge
    socket.on('get_conference', function(data){

    	$('#conf-id').data('conference_id',data.conference[0].id);
    	$('.conf-title').text(data.conference[0].title+' ('+data.conference[0].acronym+')');
    	$('#conf-location').append(data.conference[0].adress);
    	$('#conf-date').append('from '+data.conference[0].start+' to '+data.conference[0].end);
    	$('#conf-date').data('start_date', data.conference[0].start.substr(0,10));
    	$('#conf-date').data('end_date', data.conference[0].end.substr(0,10));
    	$model_id=data.conference[0].model_id;

    	//On fait une demande au serveur pour récupérer les noeuds
    	socket.emit('get_nodes', $model_id, $('#conf-id').data('conference_id'));

    	//get technical commitees confirmation
    	socket.emit('get_tcs_confirmation', $('#conf-id').data('conference_id'));
    });

    // Quand on reçoit les noeuds
    socket.on('get_nodes', function(data) {
    	//console.log(data.rows);
    	for (var nodeId in data.nodes){
    		//console.log(data.nodes[nodeId].name+' - '+data.nodes[nodeId].node_nbr);

    		$('.red-wire').append(
    			'<li class="node-list" id="node_id_'+data.nodes[nodeId].node_id+'" data-node_id="'+data.nodes[nodeId].node_id+'"">'
					+'<a class="node-a" data-openable="yes" href="#">'
						+'<span class="node-circle"></span>'
						+'<span class="node-title">'+data.nodes[nodeId].name+'</span>'
						+'<span class="node-date" data-end_date="'+data.nodes[nodeId].end_date+'">('+calc_days(data.nodes[nodeId].end_date,getDate())+' days)</span>'
						+'<span class="node-percentage">'+data.nodes[nodeId].progression+'%</span>'
					+'</a>'
					+'<ul></ul>'
				+'</li>');

    		socket.emit('get_tasks', data.nodes[nodeId].node_id, $('#conf-id').data('conference_id'));
    		socket.emit('get_tutos', data.nodes[nodeId].node_id);

    		//update node percentage color
			updateColor(data.nodes[nodeId].node_id, data.nodes[nodeId].progression);
    	}

    	$(".node-date").each(function(n){
    		if($(this).data('end_date') > $("#conf-date").data('start_date')){
    			$(this).parent().data('openable', "no");
    		}
    	});

    	//Add tooltip to nodes
		$(".node-title").each(function(n){
			if($(this).parent().data("openable") == "yes"){
				$(this).attr("data-toggle","tooltip");
				$(this).attr("data-original-title","View the tasks of this node");
			} else {
				$(this).attr("data-toggle","tooltip");
				$(this).attr("data-original-title","This node is blocked for now");
			}
		});

		//Si la date de fin du noeud est dépassée on l'affiche en rouge
		$('.node-date').each(function(n){
			if($(this).data('end_date') < getDate()){
				$(this).addClass('red');
			}
		});

		//Task tooltip
		$('.node-title').tooltip({
			placement:'left'
		});

    });

    // Quand on reçoit les taches
    socket.on('get_tasks', function(data) {
    	//console.log(data.rows);
    	for (var taskId in data.tasks){
    		console.log(data.tasks[taskId].node_id+' - '+data.tasks[taskId].name+' - '+data.tasks[taskId].limit_date);


    		if(data.tasks[taskId].limit_date != null){
    			var limit_date = data.tasks[taskId].limit_date;
    		} else {
    			var limit_date = 'none';
    		}

    		$('#node_id_'+data.tasks[taskId].node_id+' ul').append(
    			'<li class="task" id="task_'+data.tasks[taskId].id+'" data-task_id="'+data.tasks[taskId].id+'" data-validation="'+data.tasks[taskId].validation+'" data-limit_date="'+limit_date+'" data-file_uploaded="'+data.tasks[taskId].file_uploaded+'" data-toggle="tooltip" data-original-title="Show description">'+data.tasks[taskId].name+'</li>'
    		);

    	}


		//add validated glyph to tasks in the node if needed
		$("li#node_id_"+data.tasks[0].node_id+" li.task").each(function(n) {
			if($(this).data('validation') == '1'){
				$(this).append('<span class="glyphicon glyphicon-ok"></span>');
			}

			if($(this).data('limit_date') != 'none'){
				if($(this).data('validation') == '0'){
					if($(this).data('limit_date') > getDate()){
						$(this).addClass('forbidden');
						$(this).append('<span class="glyphicon glyphicon-time red"></span><span class="red">'+$(this).data('limit_date')+'</span>');
					} else {
						$(this).append('<span class="glyphicon glyphicon-time blue"></span>');
					}
				}				
			}
		});

		//Task tooltip
		$('.task').tooltip({
			placement:'right'
		});

		//nodePercentage(data.tasks[0].node_id);
		calculatePercentage();

    });


    // Quand on reçoit les infos d'une tache
    socket.on('get_task_infos', function(data) {
    	//console.log(data.task_infos);
    	$("#task-modal-title").text(data.task_infos[0].node_name+" - Task n°"+data.task_infos[0].id);
    	$("#task-modal-body-p").text(data.task_infos[0].name);
    	
    	if(data.task_infos[0].link_name != null){
    		$("#task-modal-link .panel-title").text(data.task_infos[0].link_name);
    		$("#task-modal-link .panel-body a").text(data.task_infos[0].link);
    		$("#task-modal-link").show();
    	} else {
    		$("#task-modal-link").hide();
    	}

    	if(data.task_infos[0].upload != 0){
    		$('#task-modal-upload').show();
    		if($('#task_'+data.task_infos[0].id+'').data('file_uploaded') == 0){
    			$('#task-modal-upload-input').show();
    			$('#task-modal-uploaded').hide();
    		} else {
    			$('#task-modal-upload-input').hide();
    			$('#task-modal-uploaded').show();
    		}
    	} else {
    		$('#task-modal-upload').hide();
    	}

		$("#task-modal-validate").data("task_id",data.task_infos[0].id);
		
		$("#task-modal").modal("show");
    });

    //Quand on recoit la validation d'une tache
    socket.on('validate_task', function(data){
    	$('li.task[data-task_id="'+data.task_id+'"]').append('<span class="glyphicon glyphicon-ok"></span>');
    	$('li.task[data-task_id="'+data.task_id+'"]').data('validation',1);
    	$("#task-modal").modal("hide");
    	
		nodePercentage($('li.task[data-task_id="'+data.task_id+'"]').parent().parent().data('node_id'));
		calculatePercentage();
    });

    //Quand on recoit les tutos
    socket.on('get_tutos', function(data){
    	if(data.tutos.length != 0){
    		typeTuto = false;
    		tutoPos = 0;
    		typeTool = false;
    		toolPos = 0;

    		for (var pos in data.tutos){
    			if(data.tutos[pos].type == 'tuto'){
    				typeTuto = true;
    				tutoPos = pos;
    			} else {
    				typeTool = true;
    				toolPos = pos;
    			}
    		}

    		if(typeTuto){
    			$('#node_id_'+data.tutos[0].node_id+' .node-a').append('<span class="node-tuto" data-node_id="'+data.tutos[0].node_id+'">Tutorials available</span>');
    		} 
    		if(typeTool){
    			$('#node_id_'+data.tutos[0].node_id+' .node-a').append('<span class="node-tool" data-node_id="'+data.tutos[0].node_id+'">Tools available</span>');
    		}
    		
    	}

    	for (var position in data.tutos){
    		if(data.tutos[position].type == 'tuto'){
    			$('#tuto-modal #tuto-modal-body').append(
	    			'<div class="panel panel-default" data-node_id="'+data.tutos[position].node_id+'">'
						+'<div class="panel-heading">'
							+'<h3 class="panel-title">'+data.tutos[position].name+'</h3>'
						+'</div>'
						+'<div class="panel-body">'
							+'<a href="#">'+data.tutos[position].link+'</a>'
						+'</div>'
					+'</div>'
	    		);
    		} else {
    			$('#tool-modal #tool-modal-body').append(
	    			'<div class="panel panel-default" data-node_id="'+data.tutos[position].node_id+'">'
						+'<div class="panel-heading">'
							+'<h3 class="panel-title">'+data.tutos[position].name+'</h3>'
						+'</div>'
						+'<div class="panel-body">'
							+'<a href="#">'+data.tutos[position].link+'</a>'
						+'</div>'
					+'</div>'
	    		);
    		}
    	}
    });

	// Quand on reçoit les noeuds
    socket.on('get_tcs_confirmation', function(data) {
    	conference_status = 0;
    	for (var position in data.tcs){
    		if(data.tcs[position].active == null){
    			$('#tcs_warning_list').append('<li>'+data.tcs[position].name+' : Not yet validated</li>');
    		} else if (data.tcs[position].active == 0){
    			$('#tcs_warning_list').append('<li>'+data.tcs[position].name+' : Refused</li>');
    		} else {
    			$('#tcs_warning_list').append('<li>'+data.tcs[position].name+' : Validated</li>');
    			conference_status += 1;
    		}
    	}
    	if(conference_status >= 3){ //tcs validated the conference
    		$('#tcs_warning').remove();
    	} else {
    		$('#tcs_warning').show();
    	}
    });

    //Dynamic click on a tutorial button
    $('ul.red-wire').on('click', '.node-tuto, .node-tool',function(){
    	$cliked_node_id = $(this).data('node_id');

    	if($(this).hasClass('node-tuto')){
    		$('#tuto-modal #tuto-modal-body .panel.panel-default').each(function(n){
	    		if($(this).data('node_id') == $cliked_node_id){
	    			$(this).show();
	    		} else {
	    			$(this).hide();
	    		}
	    	});
	    	$('#tuto-modal').modal("show");
    	} else if ($(this).hasClass('node-tool')){
    		$('#tool-modal #tool-modal-body .panel.panel-default').each(function(n){
	    		if($(this).data('node_id') == $cliked_node_id){
	    			$(this).show();
	    		} else {
	    			$(this).hide();
	    		}
	    	});
	    	$('#tool-modal').modal("show");
    	}
    });


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

    //Click on a node
	$('ul.red-wire').on('click', '.node-title', function() {
		if($(this).parent().data("openable") != "no"){
			var ul = $(this).parent().next(),
				clone = ul.clone().css({"height":"auto"}).appendTo("body"),
				height = ul.css("height") === "0px" ? ul[0].scrollHeight + "px" : "0px";
		
			clone.remove();

			ul.animate({"height":height});
		
		} else {
			$('#error-modal-title').text('Node unavailable');
			$('#error-modal-body').text('This node will be available when your conference is over');
			$('#error-modal').modal('show');
		}
		return false;
	});
	
	//Click on a task
	$('ul.red-wire').on('click', '.task',function(){
		if($(this).hasClass('forbidden')){
			$("#error-modal-title").text("You can't access task n°"+$(this).data("task_id")+" before "+$(this).data("limit_date"));
			$("#error-modal-body").text("This task can't be validated right now...");
			$("#error-modal").modal("show");
		} else {
			if($(this).data('validation') == 0){
				if($("#user_type").attr("data-user_type")== "tc"){
					$('#modal-footer-buttons').hide();
				}else{
					$('#modal-footer-buttons').show();
				}
				$('#modal-footer-validated').hide();
			} else {
				$('#modal-footer-buttons').hide();
				$('#modal-footer-validated').show();
			}
			socket.emit('get_task_infos', $(this).data('task_id'));
		}
	});


	function calculatePercentage(){
		var percentage = 0;
		var nbr_tasks = 0;
		$(".task").each(function(n){
			if($(this).data("validation") == "1"){
				percentage+=1;
			}
			nbr_tasks+=1;
		});
		percentage = parseInt((percentage/nbr_tasks)*100);

		$('.conference-header-right .progress.progress-striped .progress-completed').text(percentage+'%');
		$('.conference-header-right .progress.progress-striped .progress-bar.progress-bar-success').css('width', percentage+'%');
		$('.conference-header-right .progress.progress-striped .progress-bar.progress-bar-success').attr('aria-valuenow', percentage);
		
		socket.emit('update_progression',$('#conf-id').data('conference_id'),percentage);
	}


	function nodePercentage(node_id){
		var percentage = 0;
		var nbr_tasks = 0;
		$("li#node_id_"+node_id+" .task").each(function(n){
			if($(this).data("validation") == "1"){
				percentage+=1;
			}
			nbr_tasks+=1;
		});
		percentage = parseInt((percentage/nbr_tasks)*100);


		$('li#node_id_'+node_id+' .node-percentage').text(percentage+'%');
		socket.emit('update_node_progression',$('#conf-id').data('conference_id'),node_id,percentage);
		
		updateColor(node_id, percentage);
		console.log(percentage);
	}

	function updateColor(node_id, percentage){
		var color;
		if(percentage == 100){
			color = 'green';
		} else if (percentage < 100 && percentage > 0){
			color = 'orange';
		} else {
			color = 'red';
		}
		$('li#node_id_'+node_id+' span.node-percentage').css({'background-color':color, 'border-color':color});
		$('li#node_id_'+node_id).css('border-left-color',color);
		$('li#node_id_'+node_id+' .node-circle').css('border-color',color);
	}


	//Task Modal
	$('#task-modal, #error-modal, #tuto-modal').modal({
	  keyboard: false,
	  show: false
	});
	

	$("#task-modal-validate").click(function(){
		console.log($(this).data("task_id")+' - '+$('#conf-id').data('conference_id'));
		socket.emit('validate_task',$('#conf-id').data('conference_id'), $(this).data("task_id"));
	});


	//Notif
	$('#notif_button').popover({
		placement:'top',
		html : true, 
        content: function() {
          return $('#notifExampleHiddenContent').html();
        },
        title: "<span class='glyphicon glyphicon-bell' style='margin-right:10px;'></span>Notifications"
	});

	//hide edit conf for tcs
	if($("#user_type").attr("data-user_type")== "tc"){
				$('#edit_conf').hide();
	}


	$('.nav.navbar-nav li').hover(
		function() {
			$( this ).addClass( "active" );
		}, function() {
			$( this ).removeClass( "active" );
		}
	);

});
