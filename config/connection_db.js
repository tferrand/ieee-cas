var mysql = require('mysql');
var pool = mysql.createPool({
    user     : 'root',
    password : 'root',
    host     : 'localhost',
    database: 'ieee-cas',
});

exports.initPool = function(){
	return pool;
};