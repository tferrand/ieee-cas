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
            request='SELECT c.*,ctc.id as id_conf_sponsor, ctc.active from conference c INNER JOIN  conference_tc_sponsor ctc ON ctc.conference_id=c.id WHERE (ctc.tc_sponsor_id='+user_id+' AND (ctc.active=1 OR ctc.active=3)) ORDER BY c.start';
        }
        connection.query(request, function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            console.log('The solution is: ', rows);
            socket.emit('get_user_conferences', {conferences: rows});
        });
    });
}

/*var get_conference_to_sponsor = function(socket, conference_id){
    pool.getConnection(function (err, connection){
        if (err) throw err;
        var request='SELECT * from conference WHERE id = '+conference_id;
        
        connection.query(request, function(err, rows, fields) {
            connection.release();
            if (err) throw err;
            console.log("the id of the conference to sponsor : "+conference_id);
            console.log('row of the sponsors: ', rows);
            socket.emit('get_conference_to_sponsor', {conferences: rows},conference_id);
        });
    });
}*/

var set_conference_to_sponsor = function(socket, conference_id,tc_id, active){
    pool.getConnection(function (err, connection){
        if (err) throw err;
        
         console.log("UPDATING sponsor for a conference")
        var update="UPDATE conference_tc_sponsor SET active="+active+", updated_at=NOW() WHERE (conference_id="+conference_id+" AND tc_sponsor_id="+tc_id+")";
        connection.query(update, function(err, rows, fields) {
            if (err) throw err;
        });

        
        var request='SELECT * from conference WHERE id = '+conference_id;
        connection.query(request, function(err, rows, fields) {
            connection.release();
            if (err) throw err;
            socket.emit('set_conference_to_sponsor', {conferences: rows});
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

/*var get_tc_name = function(name){
    pool.getConnection(function (err, connection){
        connection.query('SELECT name FROM user WHERE type = "tc" AND id=', function(err, rows, fields) {
            connection.release();
            if (err) throw err;

            name(rows);
        });
    });
}*/

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
//exports.get_conference_to_sponsor = get_conference_to_sponsor;
exports.set_conference_to_sponsor = set_conference_to_sponsor;
exports.get_tcs = get_tcs;
exports.getTcsConfirmation = getTcsConfirmation;
