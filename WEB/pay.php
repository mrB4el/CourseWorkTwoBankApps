<?php
    //<errors>
	ini_set('error_reporting', E_ALL);
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	//</errors>
    require 'engine/template.php';
    require 'engine/MySQL_Class.php';
    require 'config.php';
    require 'dbconfig.php';
    require 'api/API.php';

    $mysql = new MySQL_Class();

    if ($api->issetParam("date")) $date = $api->getParam("date");
    if ($api->issetParam("payment")) $payment = $api->getParam("payment");
    if ($api->issetParam("secret")) $secret = $api->getParam("secret");

    $uid = $_COOKIE['uid'];

    if(!empty($uid) AND !empty($date) AND !empty($payment) AND !empty($secret))
    {
        if($mysql->send_payment($uid, $date, $payment, $secret))
        {
            echo "Ваш запрос отправен. После подтверждения ваш балланс будет изменен.";
        }
        else
        {
            echo "Что-то пошло не так";
        }
    }
    else{
        echo "кое-чего не хватает";
    }
?>