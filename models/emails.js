var pool = require('../config/connection_db').initPool();
var nodemailer = require("nodemailer");

var cronNodeMail = function(days){
		pool.getConnection(function (err, connection){
		    if (err) throw err;
		    connection.query('SELECT user.email, user.first_name, user.last_name, node.name, node_conference.progression, node_conference.end_date, conference.title, conference.id_iee from node INNER JOIN node_conference ON node.id=node_conference.node_id INNER JOIN conference ON node_conference.conference_id=conference.id INNER JOIN user ON conference.user_id=user.id WHERE node_conference.progression != 100 AND NOW() >= date_sub(node_conference.end_date,interval '+days+' day)', function(err, rows, fields) {
		        connection.release();
		        if (err) throw err;

		        for(var cronPos in rows){
		            sendTCMail(rows[cronPos]);
		        }
		    });
		});
		
}


function sendTCMail(rows){
	console.log('Envoyer un mail à '+rows.email+'.');
/*    console.log(rows.title+' - '+rows.name);
    console.log('Vous avez jusqu\'au '+rows.end_date+' pour valider le noeud "'+rows.name+'".');*/
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
        subject: "Reminder IEEE-CAS ("+rows.title+" - "+rows.name+")",
        generateTextFromHTML: true,
    	html: 	"<h3>You have a demand from "+rows.first_name+" "+rows.last_name+",</h3>"+
    			"<p>You have til <b>"+rows.end_date+"</b> to validate <b>"+rows.name+"</b> of your conference <b>\""+rows.title+"\"</b> (ID IEEE : "+rows.id_iee+").</p>"
        // text: "You have til "+rows.end_date+" to validate "+rows.name+" of your conference \""+rows.title+"\" (ID IEEE : "+rows.id_iee+")."
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