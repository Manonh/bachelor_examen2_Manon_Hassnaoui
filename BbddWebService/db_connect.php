

<?php 

/**
* un fichier pour se connecter à la base de donnée
*/

$db_user = "root"; 				//utilisateur de la bas
$db_password = ""; 				// mot de passe de la base à définir ici
$db_database = "bachelor_bdd"; 	//nom de la base de donnée
$db_server = "localhost";		//db serveur 


try {
    	$conn = new PDO("mysql:host=$db_server;dbname=$db_database", $db_user, $db_password);
    	$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    	echo "SUCCESS";
    }
catch(PDOException $e)
    {
    	die("Error with the database...");
    }

?>