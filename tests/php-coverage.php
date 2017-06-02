<?php
#require 'vendor/autoload.php';
#include 'article2-test.php';

$coverage = new PHP_CodeCoverage;

$coverage->start('coverage1');
ifthenelse( true, false );
$coverage->stop();

$coverage->start('coverage2');
ifthenelse( false, true );
$coverage->stop();

$coverage->start('Email');
$coverage->stop();

$writer = new PHP_CodeCoverage_Report_HTML;
$writer->process($coverage, '/tmp/code-coverage-report');

$writer = new PHP_CodeCoverage_Report_Clover;
$writer->process($coverage, '/tmp/clover.xml');
?>


