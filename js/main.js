$(document).ready(function(){
	// Connexion à socket.io
    var socket = io.connect('http://localhost:8080');
	
	//On fait une demande au serveur pour récupérer les noeuds
    socket.emit('get_nodes');

    // Quand on reçoit les noeuds
    socket.on('get_nodes', function(data) {
    	//console.log(data.rows);
    	for (var nodeId in data.nodes){
    		console.log(data.nodes[nodeId].name+' - '+data.nodes[nodeId].node_nbr);

    		$('.red-wire').append(
    			'<li class="node-list" id="node_id_'+data.nodes[nodeId].node_nbr+'">'
					+'<a class="node-a" data-openable="yes" href="#">'
						+'<span class="node-circle"></span>'
						+'<span class="node-title">'+data.nodes[nodeId].name+'</span>'
					+'</a>'
					+'<ul>'
					+'</ul>'
				+'</li>');

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

			//Task tooltip
			$('.node-title').tooltip({
				placement:'right'
			});

    		socket.emit('get_tasks', data.nodes[nodeId].node_nbr);
    	}

    });

    // Quand on reçoit les taches
    socket.on('get_tasks', function(data) {
    	//console.log(data.rows);
    	for (var taskId in data.tasks){
    		console.log(data.tasks[taskId].node_id+' - '+data.tasks[taskId].name+' - '+data.tasks[taskId].limit_date);


    		if(data.tasks[taskId].limit_date != null){
    			var limit_date = data.tasks[taskId].limit_date.substr(0,10);
    		} else {
    			var limit_date = 'none';
    		}

    		$('#node_id_'+data.tasks[taskId].node_id+' ul').append(
    			'<li class="task" data-task_id="'+data.tasks[taskId].id+'" data-validation="'+data.tasks[taskId].validation+'" data-limit_date="'+limit_date+'" data-toggle="tooltip" data-original-title="Show description">'+data.tasks[taskId].name+'</li>'
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

		calculatePercentage();
		nodePercentage(data.tasks[0].node_id);

    });


    // Quand on reçoit les infos d'une tache
    socket.on('get_task_infos', function(data) {
    	//console.log(data.task_infos);
    	$("#task-modal-title").text("Task n°"+data.task_infos[0].id+" - "+data.task_infos[0].name);
    	$("#task-modal-body-p").text(data.task_infos[0].description);
    	
    	if(data.task_infos[0].link_name != null){
    		$("#task-modal-link .panel-title").text(data.task_infos[0].link_name);
    		$("#task-modal-link .panel-body a").text(data.task_infos[0].link);
    		$("#task-modal-link").show();
    	} else {
    		$("#task-modal-link").hide();
    	}
    	
		
		$("#task-modal-validate").data("task_id",data.task_infos[0].id);
		
		$("#task-modal").modal("show");
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


    //Click on a node
	$('ul.red-wire').on('click', '.node-a', function() {
		if($(this).data("openable") != "no"){
			var ul = $(this).next(),
				clone = ul.clone().css({"height":"auto"}).appendTo("body"),
				height = ul.css("height") === "0px" ? ul[0].scrollHeight + "px" : "0px";
		
			clone.remove();

			ul.animate({"height":height});
		
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

		$('li#node_id_'+node_id+' span.node-title').append('<span class="node-percentage">'+percentage+'%'+'</span>');
		
		if(percentage == 100){
			updateColor(node_id, 'green');
		} else if (percentage < 100 && percentage > 0){
			updateColor(node_id, 'orange');
		} else {
			updateColor(node_id, 'red');
		}
	}

	function updateColor(node_id, color){
		$('li#node_id_'+node_id+' span.node-percentage').addClass('bg-'+color);
		$('li#node_id_'+node_id).css('border-left-color',color);
		$('li#node_id_'+node_id+' .node-circle').css('border-color',color);
	}


	//Task Modal
	$('#task-modal, #error-modal').modal({
	  keyboard: false,
	  show: false
	});
	

	$("#task-modal-validate").click(function(){
		alert($(this).data("task_id"));
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


	//New conference
	$('#new-conference-modal').modal({
	  keyboard: false,
	  show: false
	});

	$("#new-conference-btn").click(function(){
		$("#new-conference-modal").modal("show");
	});


	//geocodify
	$("#new-adress-geocodify").geocodify({
        onSelect: function (result) { 
        	//alert(result); 
        }
    });
    
	$('#new-adress-geocodify input').removeClass('geocodifyInput');
    $('#new-adress-geocodify input').addClass('form-control');
	


});