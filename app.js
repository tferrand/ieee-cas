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
// Chargement de l'ensemble des modeles

var modelNewConf = require('./models/create_conf');
var modelRedThread = require('./models/red_thread');
var modelConferences = require('./models/conferences');
var modelCron = require('./models/cron');


// --------------------------------------------------------------------------
// Lancement du serveur

server.listen(nconf.get('port'));

console.log('+---------------------------------------------------+');
console.log('|              task Management IEEE-CAS             |');
console.log('+---------------------------------------------------+');
console.log('');
console.log('Serveur HTTP : http://' + nconf.get('host') + ':' + nconf.get('port') + '/');
console.log('');


// --------------------------------------------------------------------------
// Socket

io.sockets.on('connection', function (socket, pseudo) {

    //get conf of user
    socket.on('get_user_conferences', function(user_id, user_type) {
        modelConferences.get_user_conferences(socket, user_id, user_type);
    });

    //get conf
    socket.on('get_conference', function(conference_id) {
        modelRedThread.get_conference(socket, conference_id);
    });

    //get nodes
    socket.on('get_nodes', function(model_id, conference_id) {
        modelRedThread.get_nodes(socket, model_id, conference_id);
    });

    //get tasks name and id and validation
    socket.on('get_tasks', function(node_id, conference_id) {
        modelRedThread.get_tasks(socket, node_id, conference_id);
    });

    //get tasks infos (full description)
    socket.on('get_task_infos', function(task_id) {
        modelRedThread.get_task_infos(socket, task_id);
    });

    //validate tasks
    socket.on('validate_task', function(conference_id, task_id) {
        modelRedThread.validate_task(socket, conference_id, task_id);
    });

    //update progression
    socket.on('update_progression', function(conference_id, percentage) {
        modelRedThread.update_progression(conference_id, percentage);
    });

    //update node progression
    socket.on('update_node_progression', function(conference_id, node_id, percentage) {
        modelRedThread.update_node_progression(conference_id, node_id, percentage);
    });

    //get tutos
    socket.on('get_tutos', function(node_id) {
        modelRedThread.get_tutos(socket, node_id);
    });


    //get infos création conf
    socket.on('create_conf', function(dataConf) {
        modelNewConf.createNewConf(socket, dataConf);
    });

});


/***TEST DES CRON JOBS***/ //Ca marche
modelCron.cronNodeMail(190);
/*******************/


//server.listen(8080);
 