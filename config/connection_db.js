var mysql = require('mysql');
var pool = mysql.createPool({
    user     : 'root',
    host     : 'localhost',
    port: '8889',
    database: 'ieee-cas',
});

exports.initPool = function(){
	return pool;
};
