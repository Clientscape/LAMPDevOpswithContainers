<?php
if (!defined('TEST_FILES_PATH')) {
    define('TEST_FILES_PATH', __DIR__ . DIRECTORY_SEPARATOR . 'sample' . DIRECTORY_SEPARATOR);
}

ini_set('precision', 14);
ini_set('serialize_precision', 14);

require_once __DIR__ . '/sample/autoload.php';

require_once TEST_FILES_PATH . 'email.php';
