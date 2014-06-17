var express    = require('express');
var passport   = require('passport');
var myPassport = require('./passport');
var pool=require('./connection_db').initPool();

var modelConferences = require('../models/conferences');


module.exports = function(app){

	// --------------------------------------------------------------------------------------
	// Pages de l'application

	// Page d'accueil - On redirige vers la page principale si l'utilisateur est déjà connecté
	app.get('/', function(req, res, next){

		if(myPassport.isAuthenticated(req)) res.redirect('/home');
		else res.render('login');

	});

	// Page d'accueil - Erreur lors de la connexion
	app.get('/error', function(req, res, next){

		// On génère la vue en indiquant à HoganJS l'erreur à afficher dans la vue
		res.locals = { error : 'Login or password not correct. Please retry.' };
		return res.render('login');

	});

	// Page protégée
	app.get('/home', myPassport.ensureAuthenticated, function(req, res, next){
		// modelConferences.get_tcs(function(rows){
		// 	console.log('The tcs are : ', rows);
		// 	var tcs = rows;
		// });
	
		// On génère la vue en indiquant à HoganJS les infos de l'user à afficher dans la vue
		res.locals = { 'user' : { 'id' : req.user.id, 'login' : req.user.email, 'type' : req.user.type} };
		return res.render('home');
	});



	// Page protégée
	app.get('/:login/:conference/:id', myPassport.ensureAuthenticated, function(req, res, next){
		
		pool.getConnection(function (err, connection){
            if (err) throw err;
            connection.query('SELECT user_id from conference where id_iee = '+req.params.id, function(err, rows, fields) {
                connection.release();
                if (err) throw err;

                if((req.params.email == req.user.login && rows[0].user_id == req.user.id)||req.user.type=="vpConference" ||req.user.type=="tc"){
					// On génère la vue en indiquant à HoganJS les infos de l'user à afficher dans la vue
					res.locals = { 'conference' : {'id' : req.params.id}, 'user' : { 'id' : req.user.id, 'login' : req.user.email, 'type' : req.user.type } };
					return res.render('filrouge');
				} else {
					res.locals = { 'owner' : {'id' : rows[0].user_id}, 'user' : { 'id' : req.user.id, 'login' : req.user.email,  'type' : req.user.type} };
					return res.render('private');
				}
            });
        });

	});

	// Demande de déconnexion
	app.get('/logout', function(req, res){

		req.logout();
		res.redirect('/');
	});


	// --------------------------------------------------------------------------------------
	// Politique des identifications possibles

	// Fonction générique effectuant le routage après l'authentification par Passport avec le provider indiqué
	var authenticateStrategy = function(strategy, req, res, next) {
		
		// Callback = fonction done(err, user, info) appelé depuis passport.js
		passport.authenticate(strategy, function(err, user, info) {


			console.log('--------------------------------- ');
			console.log('passport.authenticate ' + strategy);
			console.log('req  : ', req.route.method, req.route.path);
			console.log('err  : ', err);
			console.log('user : ', user);
			console.log('info : ', info);
			console.log('--------------------------------- ');

			// Authentification échouée
			if (err || !user) { 
				return res.redirect('/error');
			}

			// Authentification réussit, on demande la création d'une session par Passport
			req.login(user, function(err) {

				if (err) { return next(err); }
				return res.redirect('/home');

			});

		})(req, res, next);

	}

	// --------------------------------------------------------------------------------------
	// ROUTES : Demande de connexion | Stratégie "local"

	// Demande de connexion | Stratégie "local"
	app.post('/auth/local', function(req, res, next) { 
		authenticateStrategy('local', req, res, next);
	});


	return app;

}
