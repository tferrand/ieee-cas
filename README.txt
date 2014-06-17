--------------------------
|    Projet Web Avancé   |
--------------------------

GROUPE Rouge/Red : Jessica BESAGNI, Louis CORDELLE, Thomas FERRANDINI, Hadrien VERCIER

--------------------------
|      Instructions      |
--------------------------

Pour lancer le site : 
->	Dans le terminale : node app.js
->	Sur le navigateur : localhost:8080/


--------------------------
|     Fonctionnement     |
--------------------------

- Nous avons créé le site en suivant une architecture MVC :
--> Model : dossier /models
--> View : dossier /views
--> Controller : fichier app.js

- Le fichier app.js sert de "controller", et les intéractions entre le client et le modèle sont gérées dans ce fichier, via socket.io
- Le serveur reçoit dans la page app.js les requêtes du client via le socket, et fait appel aux fonctions crées dans les différentes pages du "model".

-Le dossier /public contient :
--> css
--> fonts
--> img
--> js : Nos fichiers javascript client (avec jQuery)
--> lib : librairies bootstrap, jquery, fullCalendar etc...
