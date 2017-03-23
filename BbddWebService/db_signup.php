<?php
/*Requete INSERT INTO*/

include"db_connect.php";

$pseudo = $_GET['pseudo'];
$password = $_GET['password'];

$result = $conn->query("INSERT INTO utilisateur (login_utilisateur, mdp_utilisateur)
		VALUES ('$pseudo', '$password')");

if($result == true) {
	echo '{"query_result":"SUCCESS"}';
}else{
	echo '{"query_result":"FAILURE"}';
}

?>