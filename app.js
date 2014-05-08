var express = require('express');
var app = express();
var server = require('http').createServer(app),
    io = require('socket.io').listen(server),
    ent = require('ent'), // Permet de bloquer les caractères HTML (sécurité équivalente à htmlentities en PHP)
    fs = require('fs');

var mysql = require('mysql');
var pool = mysql.createPool({
    user     : 'root',
    password : 'root',
    host     : 'localhost',
    port : '8889',
    database: 'ieee-cas',
});


// Chargement de la page index.html
app.get('/', function (req, res) {
  res.sendfile(__dirname + '/filrouge.html');
});

app.use(express.static(__dirname + '/'));

io.sockets.on('connection', function (socket, pseudo) {

    //get nodes
    socket.on('get_nodes', function() {
        pool.getConnection(function (err, connection){
            if (err) throw err;
            connection.query('SELECT * from node WHERE model_id = 1', function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                //console.log('The solution is: ', rows);
                socket.emit('get_nodes', {nodes: rows});
            });
        });   
    });

    //get tasks name and id
    socket.on('get_tasks', function(node_id) {
        pool.getConnection(function (err, connection){
            connection.query('SELECT tasks_list.id, tasks_list.node_id, tasks_list.name, task_validation.validation, task_validation.limit_date from tasks_list INNER JOIN task_validation ON tasks_list.id = task_validation.tasks_list_id  WHERE node_id ='+node_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                socket.emit('get_tasks', {tasks: rows});
                console.log(rows);
            });
        });
    });


    //get tasks
    socket.on('get_task_infos', function(task_id) {
        pool.getConnection(function (err, connection){
            connection.query('SELECT * from tasks_list WHERE tasks_list.id ='+task_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                socket.emit('get_task_infos', {task_infos: rows});
                console.log(rows);
            });
        });
    });

});


server.listen(8080);
