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
    
    $error = array(
        'title' => "Ошибка такая-то",
        'content' => "Косяк в том-то"
    );
         
    $tpl->title = $config["title"];
    
    
    
    $do = "main";
    
    //Получаемые параметры
	if ($api->issetParam("do")) $do = $api->getParam("do");
	if($do == "cabinet")
    {
        if (empty($_SESSION['auth']) or $_SESSION['auth'] == false)
        {
            if ( !empty($_COOKIE['uid']) and !empty($_COOKIE['session']) )
            { 
                $uid = $_COOKIE['uid']; 
                $session = $_COOKIE['session'];

                if($mysql->check_session($session, $uid, '192.168.1.1'))
                {
                    session_start();
                    //Пишем в сессию информацию о том, что мы авторизовались
                    $tpl->hello = 'fuck';
                    $tpl->requests = '0';
                    $tpl->account = $mysql->get_account($uid);
                    $tpl->payments = $mysql->get_payments($uid);
                    $tpl->credits = $mysql->get_credits($uid);

                    $tpl->content = $tpl->render('cabinet');
                }
                else
                {
                    echo 'Wrong cookies';
                }
            }
        }
    }
	//Кухня
    if($do == "main") 
    {
        $tpl->content = $tpl->render('login');
        
        if (empty($_SESSION['auth']) or $_SESSION['auth'] == false)
        {
            if ( !empty($_COOKIE['uid']) and !empty($_COOKIE['session']) )
            { 
                $uid = $_COOKIE['uid']; 
                $session = $_COOKIE['session'];

                if($mysql->check_session($session, $uid, '192.168.1.1'))
                {
                    session_start();
                    //Пишем в сессию информацию о том, что мы авторизовались:
                    $_SESSION['auth'] = true;
                    $tpl->auth = $_SESSION['auth'];
                }
                else
                {
                    echo 'Wrong cookies';
                }
            }
        }
        
        $tpl->content = $tpl->render('main');
    }
	
    if($do == "login") 
    {
		$tpl->content = $tpl->render('login');
        
        if (empty($_SESSION['auth']) or $_SESSION['auth'] == false)
        {
            if ( !empty($_COOKIE['uid']) and !empty($_COOKIE['session']) )
            { 
                $uid = $_COOKIE['uid']; 
                $session = $_COOKIE['session'];

                if($mysql->check_session($session, $uid, '192.168.1.1'))
                {
                    session_start();
                    //Пишем в сессию информацию о том, что мы авторизовались:
                    $_SESSION['auth'] = true;

                }
                else
                {
                    echo 'Wrong cookies';
                }
            }
        }

        $type = "";
        
        if ($api->issetParam("type")) $type = $api->getParam("type");
        
        if( $type == "user_login" ) {
            
            $login = "Guest";
            $password = "";
            
            if ($api->issetParam("login")) $login = $api->getParam("login");
            if ($api->issetParam("password")) $password = $api->getParam("password");
            
            $password = md5($password);
            
            $uid = $mysql->check_login($login, $password);
            
            

            if($uid == 0)
            {
                $error['title'] = "Ошибка с профилем";
                $error['content'] = "Такой пары пользователь/пароль не существует";
                $tpl->error = $error;
                $tpl->system_messages = $tpl->render('error');
            }
            else 
            {

               
                session_start();
                //Пишем в сессию информацию о том, что мы авторизовались:
                $_SESSION['auth'] = true;

                /*
                    Пишем в сессию логин и id пользователя
                    (их мы берем из переменной $user!):
                */
                $_SESSION['id'] = $uid; 
                $_SESSION['login'] = $login; 
                
                $session = md5($login); //назовем ее $key

                //Пишем куки (имя куки, значение, время жизни - сейчас+месяц)
                setcookie('uid', $uid, time()+60*60*24*30); //логин
                setcookie('session', $session, time()+60*60*24*30); //случайная строка
                
                $mysql->create_session($session, $uid, '192.168.1.1');

                header( 'Refresh: 0; url=/' );

                
            }
        }
        
	}
    
    if($do == "registration") 
    {
		$tpl->content = $tpl->render('user_register');
        
        $type = "";
        
        if ($api->issetParam("type")) $type = $api->getParam("type");
        
        
        // /index.php?do=registration&type=user_registration&login=mrB4el&password1=123456&password2=123456
        if($type == "user_registration") {
            $username = "Guest";
            $password1 = "";
            $password2 = "";
            
            if ($api->issetParam("email")) $email = $api->getParam("email");
            if ($api->issetParam("username")) $username = $api->getParam("username");
            //сделать проверку логина
            if ($api->issetParam("password1")) $password1 = $api->getParam("password1");
            if ($api->issetParam("password2")) $password2 = $api->getParam("password2");

            if ($api->issetParam("first_name")) $first_name = $api->getParam("first_name");
            if ($api->issetParam("last_name")) $last_name = $api->getParam("last_name");
            if ($api->issetParam("middle_name")) $middle_name = $api->getParam("middle_name");
                        
            if( !empty($password1) AND !empty($password2) AND !empty($username) AND !empty($first_name) AND !empty($last_name) AND !empty($middle_name) AND !empty($email))
            {
            
                if ($password1 == $password2)
                {
                    $mysql->register($email, $username, $password1, $first_name, $last_name, $middle_name);
                    echo "Register success";
                }
                else {
                    $error['title'] = "Ошибка с паролями";
                    $error['content'] = "Пароли не совпадают";
                    $tpl->error = $error;
                    $tpl->system_messages = $tpl->render('error');
                }
            }
            else {
                $error['title'] = "Упс";
                $error['content'] = "Поля регистрации не могут быть пустыми";
                $tpl->error = $error;
                $tpl->system_messages = $tpl->render('error');
            }
        }        
	}
        
    echo $tpl->render('index');
    
?>