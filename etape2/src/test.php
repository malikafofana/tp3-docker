<?php
$host = "data";
$user = "monuser";
$password = "password";
$db = "mabase";

$mysqli = @new mysqli($host, $user, $password, $db);
if ($mysqli->connect_error) {
    die("<h3>Erreur connexion MariaDB : " . htmlspecialchars($mysqli->connect_error) . "</h3>");
}

/* 1) ECRITURE : on insère (nb = MAX(compteur)+1) */
$ins = $mysqli->query("INSERT INTO matable (compteur)
                       SELECT COALESCE(MAX(compteur),0)+1 FROM matable");
if (!$ins) {
    die("<h3>Erreur INSERT : " . htmlspecialchars($mysqli->error) . "</h3>");
}

/* 2) LECTURE : on récupère la valeur courante */
$res = $mysqli->query("SELECT MAX(compteur) AS nb FROM matable");
$row = $res ? $res->fetch_assoc() : ["nb" => null];
$nb = $row && isset($row["nb"]) ? (int)$row["nb"] : 0;

echo "<h1>Count updated</h1>";
echo "<h2>Count : " . $nb . "</h2>";

$mysqli->close();
