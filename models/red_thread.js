var pool = require('../config/connection_db').initPool();

var get_conference = function(conference_id, callback){
	pool.getConnection(function (err, connection){
	    connection.query('SELECT * from conference WHERE id_iee = '+conference_id, function(err, rows, fields) {
	        connection.release();
	        if (err) throw err;

	        //console.log('The solution is: ', rows);
            callback({conference: rows});
	        //socket.emit('get_conference', {conference: rows});
	    });
	});
}

var get_nodes = function(model_id, conference_id, callback){
	pool.getConnection(function (err, connection){
        connection.query('SELECT * from node INNER JOIN node_conference ON node.id = node_conference.node_id WHERE node_conference.conference_id = '+conference_id+' AND model_id='+model_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            //console.log('The solution is: ', rows);
            callback({nodes: rows});
            //socket.emit('get_nodes', {nodes: rows});
        });
    });
}

var get_tasks = function(node_id, conference_id, callback){
	pool.getConnection(function (err, connection){
        connection.query('SELECT tasks_list.id, tasks_list.node_id, tasks_list.name, task_validation.validation, task_validation.limit_date, task_validation.file_uploaded from tasks_list INNER JOIN task_validation ON tasks_list.id = task_validation.tasks_list_id  WHERE node_id ='+node_id+' AND task_validation.conference_id='+conference_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            callback({tasks: rows});
            //socket.emit('get_tasks', {tasks: rows});
            console.log(rows);
        });
    });
}

var get_task_infos = function (task_id, callback) {
	pool.getConnection(function (err, connection){
        connection.query('SELECT tasks_list.id, tasks_list.node_id, tasks_list.name, tasks_list.description, tasks_list.link, tasks_list.link_name, tasks_list.date, tasks_list.upload, node.name as node_name from tasks_list INNER JOIN node ON node.id = tasks_list.node_id WHERE tasks_list.id ='+task_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            callback({task_infos: rows});
            //socket.emit('get_task_infos', {task_infos: rows});
            console.log(rows);
        });
    });
}

var validate_task = function (conference_id, task_id, callback) {
	pool.getConnection(function (err, connection){
        connection.query('UPDATE task_validation SET validation = 1 WHERE conference_id='+conference_id+' AND tasks_list_id='+task_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            callback({task_id: task_id});
            //socket.emit('validate_task', {task_id: task_id});
        });
    });
}

var update_progression = function(conference_id, percentage){
	pool.getConnection(function (err, connection){
        connection.query('UPDATE conference SET progression = '+percentage+' WHERE id='+conference_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;
        });
    });
}

var update_node_progression = function(conference_id, node_id, percentage){
	pool.getConnection(function (err, connection){
        connection.query('UPDATE node_conference SET progression = '+percentage+' WHERE conference_id='+conference_id+' AND node_id='+node_id+'', function(err, rows, fields) {
            connection.release();
            if (err) throw err;
        });
    });
}

var get_tutos = function(node_id, callback){
	pool.getConnection(function (err, connection){
        connection.query('SELECT * FROM node LEFT OUTER JOIN tuto ON node.id = tuto.node_id WHERE node_id ='+node_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            callback({tutos: rows});
            //socket.emit('get_tutos', {tutos: rows});
            console.log(rows);
        });
    });
}


exports.get_conference = get_conference;
exports.get_nodes = get_nodes;
exports.get_tasks = get_tasks;
exports.get_task_infos = get_task_infos;
exports.validate_task = validate_task;
exports.update_progression = update_progression;
exports.update_node_progression = update_node_progression;
exports.get_tutos = get_tutos;