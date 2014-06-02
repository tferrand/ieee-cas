var pool = require('../config/connection_db').initPool();
var nodemailer = require("nodemailer");
var cronJob = require('cron').CronJob;

var cronNodeMail = function(days){
	var job = new cronJob({
		cronTime: '00 36 16 * * 0-6',
		onTick: function() {
		// Runs every weekday (Monday through Friday)
		// at 11:30:00 AM. It does not run on Saturday
		// or Sunday.
		pool.getConnection(function (err, connection){
		    if (err) throw err;
		    connection.query('SELECT user.email, node.name, node_conference.end_date, conference.title from node INNER JOIN node_conference ON node.id=node_conference.node_id INNER JOIN conference ON node_conference.conference_id=conference.id INNER JOIN user ON conference.user_id=user.id WHERE node_conference.progression != 100 AND NOW() >= date_sub(node_conference.end_date,interval '+days+' day)', function(err, rows, fields) {
		        connection.release();
		        if (err) throw err;

		        for(var cronPos in rows){
		            sendNodeMail(rows[cronPos]);
		        }
		    });
		});
		},
		start: false
	});
	job.start();
}


function sendNodeMail(rows){
	console.log('Envoyer un mail à '+rows.email+'.');
    console.log(rows.title);
    console.log('Vous avez jusqu\'au '+rows.end_date+' pour valider le noeud "'+rows.name+'".');
    console.log('');

    var transport = nodemailer.createTransport("SMTP", {
        service: "Gmail",
        auth: {
            user: "reminder.ieee.cas@gmail.com",
            pass: "passieee"
        }
    });

    var mailOptions = {
        from: "tomscoop91@gmail.com",
        to: rows.email,
        subject: "Reminder IEEE-CAS",
        text: "Conference "+rows.title+" : You have til "+rows.end_date+" to validate node "+rows.name+"."
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

exports.cronNodeMail = cronNodeMail;