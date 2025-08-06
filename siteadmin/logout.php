<?php
ini_set('session.save_path', '/tmp');
session_start();
define('_VALID', true);
define('_ADMIN', true);
require('../include/config.php');

$_SESSION['AUID'] 		= '';
$_SESSION['APASSWORD'] 	= '';
unset($_SESSION['AUID']);
unset($_SESSION['APASSWORD']);

session_write_close();
header('Location: index.php');
die();
?>

