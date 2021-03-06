var pool = require('../config/connection_db').initPool();

var get_user_conferences = function(user_id, user_type, callback){
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
            callback({conferences: rows});
        });
    });
}

var set_conference_to_sponsor = function(conference_id,tc_id, active, callback){
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
            callback({conferences: rows});
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

var getTcsConfirmation = function(conference_id, callback){
    pool.getConnection(function (err, connection){
        connection.query('SELECT user.name, conference_tc_sponsor.active FROM conference_tc_sponsor INNER JOIN user ON user.id = conference_tc_sponsor.tc_sponsor_id WHERE conference_id ='+conference_id, function(err, rows, fields) {
            connection.release();
            if (err) throw err;
            console.log('the tcs are :'+rows);
            callback({tcs : rows});
        });
    });
}

var editConference = function(conference_id, dataEdit, callback){
    console.log(dataEdit);
    pool.getConnection(function (err, connection){
        connection.query('UPDATE conference SET title="'+dataEdit.edit_title+'", acronym="'+dataEdit.edit_acronym+'", adress="'+dataEdit.edit_adress+'", description="'+dataEdit.edit_description+'" WHERE id = '+conference_id, function(err, rows, fields) {
            connection.release();
            if (err){
                callback({response: "error"});
            } else {
                callback({response: "ok"});
            }
        });
    });
}

exports.get_user_conferences = get_user_conferences;
//exports.get_conference_to_sponsor = get_conference_to_sponsor;
exports.set_conference_to_sponsor = set_conference_to_sponsor;
exports.get_tcs = get_tcs;
exports.getTcsConfirmation = getTcsConfirmation;
exports.editConference = editConference;
