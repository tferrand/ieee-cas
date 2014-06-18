var pool = require('../config/connection_db').initPool();
var nodemailer = require("nodemailer");
var nconf = require('nconf');
nconf.file({ file: 'settings.json' });



var createNewConf = function(socket, dataConf){
    console.log(dataConf);
    //we have to get the start_date and end_date here to calculate the period to put in node_conference
    pool.getConnection(function (err, connection){
        connection.query('INSERT INTO conference (id_iee, title, acronym, adress, description, start, end, user_id, model_id, created_at, updated_at) VALUES ('+dataConf.new_id_ieee+',"'+dataConf.new_title+'","'+dataConf.new_acronym+'","'+dataConf.new_adress+'","'+dataConf.new_description+'","'+dataConf.new_start+'","'+dataConf.new_end+'", "'+dataConf.user_id+'", "'+dataConf.model_id+'", NOW(), NOW())', function(err, rows, fields) {
            if (err) throw err;

            console.log(rows.insertId);
            select_node_list(connection, rows.insertId, dataConf.new_start); //create node for new conference
            select_tasks_list(connection, rows.insertId); //create tasks for new conference
            insert_tcs(connection, dataConf.new_tcs, rows.insertId); //create tcs relations with conference

            connection.release();

            socket.emit('create_conf_ok');
        });
    });
}

function insert_tcs(connection, tcs, conference_id){
    console.log('IN INSERT_TCS');
    console.log(tcs);
    for (var i = 0; i < tcs.length; i++) {
        console.log('tcs : '+tcs[i]);
        connection.query('INSERT INTO conference_tc_sponsor (tc_sponsor_id, conference_id, created_at, updated_at) VALUES ('+tcs[i]+', '+conference_id+', NOW(), NOW())', function(err, rows, fields) {
            if (err) throw err;
        });
        connection.query('SELECT email FROM user WHERE id='+tcs[i], function(err, rows, fields) {
            sendTCMail(rows[0].email,conference_id)
            if (err) throw err;
        });
    }
}

function select_tasks_list(connection, conference_id){
    connection.query('SELECT tasks_list.id FROM tasks_list INNER JOIN node ON tasks_list.node_id = node.id WHERE node.model_id = 1 ORDER BY tasks_list.node_id', function(err, rows, fields) {
        if (err) throw err;
        create_task_validation(connection, rows, conference_id);
    });
}

function create_task_validation(connection, tasks, conference_id){
    for (var i = 0; i < tasks.length; i++) {
        console.log(tasks[i].id);
        connection.query('INSERT INTO task_validation (conference_id, tasks_list_id, created_at, updated_at) VALUES ('+conference_id+', '+tasks[i].id+', NOW(), NOW())', function(err, rows, fields) {
            if (err) throw err;
        });
    }
}

function select_node_list(connection, conference_id, conference_start){
    console.log('In select_node_list()');
    connection.query('SELECT id, percentage FROM node WHERE model_id = 1 ORDER BY node_nbr', function(err, rows, fields) {
        if (err) throw err;
        console.log('In select_node_list() query');
        create_node_conference(connection, rows, conference_id, conference_start);
    });
}

function create_node_conference(connection, nodes, conference_id, conference_start){
    console.log('In create_node_conference()');
    for (var i = 0; i < nodes.length; i++) {
        console.log(nodes[i].id);

        var confStartDate = new Date(conference_start);
        var currentDate = new Date(getDate());

        var period = confStartDate.getTime() - currentDate.getTime();
        period = Math.ceil(period / 1000 / 60 / 60 / 24);

        var node_days = (period*nodes[i].percentage)/100;
        connection.query('INSERT INTO node_conference (node_id, conference_id, progression, end_date) VALUES ('+nodes[i].id+', '+conference_id+', 0, DATE_ADD(NOW(), INTERVAL '+node_days+' day))', function(err, rows, fields) {
            if (err) throw err;
        });
    }
}


function getDate() {
    var now     = new Date(); 
    var year    = now.getFullYear();
    var month   = now.getMonth()+1; 
    var day     = now.getDate();

    if(month.toString().length == 1) {
        var month = '0'+month;
    }
    if(day.toString().length == 1) {
        var day = '0'+day;
    }   
    var date = year+'-'+month+'-'+day+' 00:00:00';   
    return date;
}

function sendTCMail(email,id_conference){
    console.log('Envoyer un mail à '+email+'.');

    console.log('');

    var transport = nodemailer.createTransport("SMTP", {
        service: "Gmail",
        auth: {
            user: "reminder.ieee.cas@gmail.com",
            pass: "passieee"
        }
    });

    var mailOptions = {
        from: "reminder.ieee.cas@gmail.com",
        to: email,
        subject: "Sponsor IEEE-CAS conference",
        generateTextFromHTML: true,
        html:   '<h3>Hello,</h3><p>You have a demand for a Sponsorship : <a href="http://' + nconf.get('host') + ':' + nconf.get('port') + '/home">See the conference</a>'
        
    }

    transport.sendMail(mailOptions, function(error, response){  //callback
        if(error){
           console.log(error);
        }else{
           console.log("Message sent: " + response.message);
        }
        transport.close(); // shut down the connection pool, no more messages.  Comment this line out to continue sending emails.
    });
}

var getUserConfModels = function(socket, user_id){
    pool.getConnection(function (err, connection){
        connection.query('SELECT model_id, title, acronym, adress, description FROM conference WHERE user_id='+user_id+' ORDER BY id desc', function(err, rows, fields) {
            if (err) throw err;

            connection.release();

            console.log(rows);
            socket.emit('get_user_conf_models', {conf_models : rows});
        });
    });
}

exports.createNewConf = createNewConf;
exports.getUserConfModels = getUserConfModels;
