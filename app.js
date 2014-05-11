var nconf = require('nconf');
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io').listen(server);
var ent = require('ent'); // Permet de bloquer les caractères HTML (sécurité équivalente à htmlentities en PHP)
var myPassport = require('./config/passport');
var myConfig   = require('./config/config');
var myRoutes   = require('./config/routes');

var mysql = require('mysql');
var pool = mysql.createPool({
    user     : 'root',
    password : 'root',
    host     : 'localhost',
    port : '8889',
    database: 'ieee-cas',
});


// --------------------------------------------------------------------------
// Chargement des variables de configuration

nconf.file({ file: 'settings.json' });


// --------------------------------------------------------------------------
// Chargement de l'ensemble des modules

myConfig(app);          // Configuration de Express
myPassport.init(app);   // Configuration de Passport
myRoutes(app);          // Configuration du routage


// --------------------------------------------------------------------------
// Lancement du serveur

server.listen(nconf.get('port'));

console.log('+---------------------------------------------------+');
console.log('|              task Management IEEE-CAS             |');
console.log('+---------------------------------------------------+');
console.log('');
console.log('Serveur HTTP : http://' + nconf.get('host') + ':' + nconf.get('port') + '/');
console.log('');


io.sockets.on('connection', function (socket, pseudo) {

    //get conf of user
    socket.on('get_user_conferences', function(user_id) {
        pool.getConnection(function (err, connection){
            if (err) throw err;
            connection.query('SELECT * from conference WHERE user_id = '+user_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                //console.log('The solution is: ', rows);
                socket.emit('get_user_conferences', {conferences: rows});
            });
        });   
    });

    //get conf
    socket.on('get_conference', function(conference_id) {
        pool.getConnection(function (err, connection){
            if (err) throw err;
            connection.query('SELECT * from conference WHERE id_iee = '+conference_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                //console.log('The solution is: ', rows);
                socket.emit('get_conference', {conference: rows});
            });
        });   
    });

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


//server.listen(8080);
