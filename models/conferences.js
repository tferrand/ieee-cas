var pool = require('../config/connection_db').initPool();

var get_user_conferences = function(socket, user_id, user_type){
	pool.getConnection(function (err, connection){
        if (err) throw err;
        var request='SELECT * from conference WHERE user_id = '+user_id+' ORDER BY start';
        console.log(user_type);
        if(user_type=="vpConference"){
            request='SELECT * from conference ORDER BY start';
        }
        connection.query(request, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            console.log('The solution is: ', rows);
            socket.emit('get_user_conferences', {conferences: rows});
        });
    });
}

exports.get_user_conferences = get_user_conferences;