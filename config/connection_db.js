var mysql = require('mysql');
var pool = mysql.createPool({
    user     : 'root',
    password : '',
    host     : 'localhost',
    database: 'ieee-cas',
    port : '8889',
    dateStrings : true,
});

exports.initPool = function(){
	return pool;
};
