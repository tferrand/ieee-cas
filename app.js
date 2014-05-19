var nconf = require('nconf');
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var io = require('socket.io').listen(server);
var ent = require('ent'); // Permet de bloquer les caractères HTML (sécurité équivalente à htmlentities en PHP)
var myPassport = require('./config/passport');
var myConfig   = require('./config/config');
var myRoutes   = require('./config/routes');
var pool       = require('./config/connection_db').initPool();



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

                console.log('The solution is: ', rows);
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
    socket.on('get_nodes', function(model_id) {
        pool.getConnection(function (err, connection){
            if (err) throw err;
            connection.query('SELECT * from node WHERE model_id='+model_id, function(err, rows, fields) {
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


    //validate tasks
    socket.on('validate_task', function(conference_id, task_id) {
        pool.getConnection(function (err, connection){
            connection.query('UPDATE task_validation SET validation = 1 WHERE conference_id='+conference_id+' AND tasks_list_id='+task_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                socket.emit('validate_task', {task_id: task_id});
            });
        });
    });

    //update progression
    socket.on('update_progression', function(conference_id, percentage) {
        pool.getConnection(function (err, connection){
            connection.query('UPDATE conference SET progression = '+percentage+' WHERE id='+conference_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

            });
        });
    });

    //get tutos
    socket.on('get_tutos', function(node_id) {
        pool.getConnection(function (err, connection){
            connection.query('SELECT * FROM node LEFT OUTER JOIN tuto ON node.id = tuto.node_id WHERE node_id ='+node_id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                socket.emit('get_tutos', {tutos: rows});
                console.log(rows);
            });
        });
    });

    //create tasks for new conference
    socket.on('create_tasks', function(conference_id) {
        pool.getConnection(function (err, connection){
            connection.query('SELECT tasks_list.id FROM tasks_list INNER JOIN node ON tasks_list.node_id = node.id WHERE node.model_id = 1 ORDER BY tasks_list.node_id', function(err, rows, fields) {
                //connection.release();
                if (err) throw err;

                insert_validation(rows, conference_id);
                
            });
        });        
    });

    function insert_validation(tasks, conference_id){
        pool.getConnection(function (err, connection){
            for (var i = 0; i < tasks.length; i++) {
                console.log(tasks[i].id);
                connection.query('INSERT INTO task_validation (conference_id, tasks_list_id) VALUES ('+conference_id+', '+tasks[i].id+')', function(err, rows, fields) {
                    connection.release();
                    if (err) throw err;

                });
            }
        });
    }



});


//server.listen(8080);
 