<?php
ini_set('session.save_path', '/tmp');
session_start();

if (!isset($_SESSION['test'])) {
    $_SESSION['test'] = 'Hello Session!';
} else {
    echo $_SESSION['test'];
}
?>
