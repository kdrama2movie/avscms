<?php
ini_set('session.save_path', '/tmp');
session_start();
define('_VALID', true);
define('_ADMIN', true);
require '../include/config.php';
require '../classes/auth.class.php';

Auth::checkAdmin();
echo phpinfo();

?>
