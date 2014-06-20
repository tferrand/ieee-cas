var pool = require('../config/connection_db').initPool();

var uploadFile = function(data, callback){
    pool.getConnection(function (err, connection){
        connection.query('INSERT INTO files (conference_id, task_id, name, path) VALUES ('+data.conference_id+','+data.task_id+',"'+data.name+'","'+data.name+'")', function(err, rows, fields) {
            if (err) {
            	throw err;
                callback({response: "error"});
            	//socket.emit('file_upload', {response: "error"});
            } else {
            	connection.query('UPDATE task_validation SET file_uploaded=1 WHERE conference_id='+data.conference_id+' AND tasks_list_id='+data.task_id+'', function(err, rows, fields) {
		            if (err) {
		            	throw err;
		            } else {
                        callback({response: "ok", task_id: data.task_id});
		            	//socket.emit('file_upload', {response: "ok", task_id: data.task_id});
		            }
		        });
            }
            connection.release();
        });
    });
}

exports.uploadFile = uploadFile;