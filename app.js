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

var ss = require('socket.io-stream'); // for file uploading
var path = require('path');
var fs = require("fs");

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
var modelUpload = require('./models/upload');


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
        modelConferences.get_user_conferences(user_id, user_type, function(data){
            socket.emit('get_user_conferences', data);
        });
    });

    //get conf
    socket.on('get_conference', function(conference_id) {
        modelRedThread.get_conference(conference_id, function(data){
            socket.emit('get_conference', data);
        });
    });

    //set sponsor conf
    socket.on('set_conference_to_sponsor', function(conference_id,tc_id,active) {
        modelConferences.set_conference_to_sponsor(conference_id,tc_id, active, function(data){
            socket.emit('set_conference_to_sponsor', data);
        });
    });

    //get nodes
    socket.on('get_nodes', function(model_id, conference_id) {
        modelRedThread.get_nodes(model_id, conference_id, function(data){
            socket.emit('get_nodes', data);
        });
    });

    //get tasks name and id and validation
    socket.on('get_tasks', function(node_id, conference_id) {
        modelRedThread.get_tasks(node_id, conference_id, function(data){
            socket.emit('get_tasks', data);
        });
    });

    //get tasks infos (full description)
    socket.on('get_task_infos', function(task_id) {
        modelRedThread.get_task_infos(task_id, function(data){
            socket.emit('get_task_infos', data);
        });
    });

    //validate tasks
    socket.on('validate_task', function(conference_id, task_id) {
        modelRedThread.validate_task(conference_id, task_id, function(data){
            socket.emit('validate_task', data);
        });
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
        modelRedThread.get_tutos(node_id, function(data){
            socket.emit('get_tutos', data);
        });
    });

    //get infos création conf
    socket.on('create_conf', function(dataConf) {
        modelNewConf.createNewConf(dataConf, function(data){
            socket.emit(data);
        });
    });

    //Upload de fichiers
    ss(socket).on('file', function(stream, data) {
        var filename = path.basename(data.name);
        stream.pipe(fs.createWriteStream(__dirname+'/uploaded_files/'+filename)); 
    });

    //Insert file name in db
    socket.on('insert_file_db', function(data){
        modelUpload.uploadFile(data, function(response){
            socket.emit('file_upload', response);
        });
    });

    //get tcs confirmation status
    socket.on('get_tcs_confirmation', function(conference_id){
        modelConferences.getTcsConfirmation(conference_id, function(data){
            socket.emit('get_tcs_confirmation', data);
        });
    });

    //get models conference from user
    socket.on('get_user_conf_models', function(user_id){
        modelNewConf.getUserConfModels(user_id, function(data){
            socket.emit('get_user_conf_models', data);
        });
    });

    //edit conference
    socket.on('edit_conference', function(conference_id, dataEdit){
        modelConferences.editConference(conference_id, dataEdit, function(data){
            socket.emit('edit_conference', data);
        });
    });

});

/***TEST DES CRON JOBS***/ //Cron 5 jours avant la fin de chaque noeud
modelCron.cronNodeMail(5);
/*******************/