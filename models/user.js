
var pool=require('../config/connection_db').initPool();


// On stocke les utilisateurs dans un tableau javascript statique pour l'exemple




var findUserSQL = function(loginUser,password,callback) {

	pool.getConnection(function (err, connection){
            if (err) throw err;
            var md5 = require("../public/lib/md5.js").md5;
            var hash=md5(password);
            connection.query("SELECT * FROM user WHERE email='"+loginUser+"' AND password='"+hash+"'", function(err, rows, fields) {
                connection.release();
                console.log(rows);
                return callback(null, rows[0]);

                
            });
        });
	

};

var findUserSQLById = function(id,callback) {

	pool.getConnection(function (err, connection){
            if (err) throw err;
            
            connection.query("SELECT * FROM user WHERE id="+id, function(err, rows, fields) {
                connection.release();
                if (err) return callback(null, null);
                callback(null, rows[0]);
                return;

                
            });
        });
	

};

	




// On exporte les fonctions pouvant être accessibles depuis les autres modules
module.exports = {
	'findUserSQL'				   : findUserSQL,
	'findUserSQLById'			   : findUserSQLById

}
