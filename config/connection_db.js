var mysql = require('mysql');
var pool = mysql.createPool({
    user     : 'root',
    password : '',
    host     : 'localhost',
    port: '8889',
    database: 'ieee-cas',
    dateStrings : true,
});

exports.initPool = function(){
	return pool;
};
