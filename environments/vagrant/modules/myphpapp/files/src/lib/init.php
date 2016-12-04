<?php

// application constants
define('MYPHPAPP_START', microtime(true));

if (!defined('INSTALL_PATH')) {
    define('INSTALL_PATH', dirname($_SERVER['SCRIPT_FILENAME']).'/');
}

if (!defined('MYPHPAPP_CONFIG_DIR')) {
    define('MYPHPAPP_CONFIG_DIR', INSTALL_PATH . 'config');
}

require_once INSTALL_PATH . '/lib/myphpapp.php';
$app = new Myphpapp;
