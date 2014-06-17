var pool = require('../config/connection_db').initPool();

var get_user_conferences = function(socket, user_id, user_type){
	pool.getConnection(function (err, connection){
        if (err) throw err;
        var request='SELECT * from conference WHERE user_id = '+user_id+' ORDER BY start';
        console.log(user_type);
        if(user_type=="vpConference"){
            request='SELECT * from conference ORDER BY start';
        }
        if(user_type=="tc"){
            request='SELECT c.* from conference c INNER JOIN  conference_tc_sponsor ctc ON ctc.conference_id=c.id WHERE (ctc.tc_sponsor_id='+user_id+' AND ctc.active=1) ORDER BY c.start';
        }
        connection.query(request, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            console.log('The solution is: ', rows);
            socket.emit('get_user_conferences', {conferences: rows});
        });
    });
}

var get_tcs = function(cb){
    pool.getConnection(function (err, connection){
        connection.query('SELECT name, id FROM user WHERE type = "tc"', function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            cb(rows);
        });
    });
}

var getTcsConfirmation = function(socket, conference_id){
    pool.getConnection(function (err, connection){
        connection.query('SELECT user.name, conference_tc_sponsor.active FROM conference_tc_sponsor INNER JOIN user ON user.id = conference_tc_sponsor.tc_sponsor_id WHERE conference_id ='+conference_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;
            console.log('the tcs are :'+rows);
            socket.emit('get_tcs_confirmation', {tcs : rows});
        });
    });
}

exports.get_user_conferences = get_user_conferences;
exports.get_tcs = get_tcs;
exports.getTcsConfirmation = getTcsConfirmation;
