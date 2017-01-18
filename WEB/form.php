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

    if ($api->issetParam("quantity")) $quantity = $api->getParam("quantity");
    if ($api->issetParam("percents")) $percents = $api->getParam("percents");
    if ($api->issetParam("days")) $days = $api->getParam("days");
    if ($api->issetParam("phone")) $phone = $api->getParam("phone");

    $uid = $_COOKIE['uid'];

    if(!empty($uid) AND !empty($quantity) AND !empty($percents) AND !empty($days) AND !empty($phone))
    {
        if($mysql->send_request($uid, $quantity, $percents, $days, $phone))
        {
            echo "Ваш запрос отправен. С вами сважется оператор";
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