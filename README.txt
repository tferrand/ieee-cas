--------------------------
|    Projet Web Avancé   |
--------------------------

GROUPE Rouge/Red : Jessica BESAGNI, Louis CORDELLE, Thomas FERRANDINI, Hadrien VERCIER

--------------------------
|      Instructions      |
--------------------------

- Installer la base de donnée MySQL avec le nom "ieee-cas" à partir du fichier ieee-cas.sql à la racine du site.
- Dans le fichier config/connection_db.js, modifiez si besoin le nom d'utilisateur et le mot de passe de connexion à la base de données qui sont par défaut "root" et "root".

Si vous êtes sur Windows avec WAMP : Il faut supprimer la ligne  "port : '8889'," du fichier config/connection_db.js


Pour lancer le site : 
->	Dans le terminal : node app.js
->	Sur le navigateur : localhost:8080/


--------------------------
|    Scenario de Test    |
--------------------------

(1) Connexion en tant qu'organisateur :
---------------------------------------

- Se connecter avec le compte "tferrand@isep.fr" et le mot de passe "azerty". Ceci est une connexion en mode "Organisateur de conférences" (c'est aussi précisé en haut à droite de la fenêtre après la connexion.

- Vous pouvez alors créer une conférence grâce à l'onglet du menu du haut "Create New Conference" :
--> Si vous choisissez "Blank", vous creérez une conférence à partir de champs vides
--> En choisissant "From Model", vous pourrez créer une conférence à partir du modèle de vos anciennes conférences, ce qui pré-remplira quelques champs comme le lieu, le titre, etc.
La date de fin de chaque noeud est calculée lors de la créattion de la conférence en fonction de la date de début de la conférence.

(Veillez à sélectionner au moins le premier Technical commitee "Analog Signal Processing" pour pouvoir tester la fonction de sponsor d'une conférence lorsque vous vous connecterez avec en tant que Technical committee sur ce compte)

- Après avoir créer une conférence vous pourrez vous rendre sur le fil rouge en cliquant sur le bouton "See red wire".
- En cliquant sur les noeuds, la liste des tâches de chaque noeud est affiché
- En cliquant sur une tâche, un fenêtre modale apparait et on peut valider la tâche, et le pourcentage de progression de chaque noeud est mis à jour ainsi que la couleur du fil rouge.
- Certaines tâches comme la "Establish a call for paper" du Noeud 3 permettent d'uploader un document, qui sera enregistré dans le dossier "uploaded_files"

- 5 jours avant la date de fin de chaque noeud, un mail sera envoyé aux organisateurs si les tâches de ce noeud ne sont pas toutes validées. (Grâce à un CRON)

- Certains noeuds possèdent des tutoriaux et des logiciels attachés, que l'on peut afficher en cliquant sur les boutons respectifs "Tutorials available" et "Tools available"

- Les noeuds situés après le noeud 10 ne seront disponibles qu'une fois la conférence passée.

- Lorsque 3 Technical commitees auront sponsorisé la conférence, le message dans la boite de dialogue rouge dans le fil rouge disparaitra.



(2) Connexion en tant que Technical commitee :
----------------------------------------------

- Se connecter avec l'identifiant "tc1@ieee.com" et le mot de passe : "tc"

- Dans cette interface on peut voir en tant que "Technical commitee", les conférences que l'on parraine, et les demandes de parrainage de conférence :
--> Dans le cas où l'on parraine, on peut voir le fil rouge de la conférence, mais pas valider les tâches
--> Dans le cas d'une demande de parrainage, on peut soit accepter et accèder au fil rouge, soit refuser de parrainer la conférence. (boutons "Sponsor it" et "Decline")



(3) Connexion en tant que VP Conference :
-----------------------------------------

- Se connecter avec l'identifiant : "vp@isep.fr" et le mot de passe : "vp"
- On accède à l'interface du VP qui est presque la même que celle d'un organisateur, sauf que lui voit toutes les conférences de tous les organisateurs.
- Il peut valider des tâches etc, comme un organisateur.



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