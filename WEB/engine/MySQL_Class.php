<?php
    class MySQL_Class{  
        
        var $mysqli;

        function __construct()
        {
            $this->mysqli = new mysqli(DBHOST, DBUSER, DBPASS, DBNAME);
        }

        function register($email, $username, $password, $first_name, $last_name, $middle_name)
        {
            $uid = 0;
                
            $password = md5($password);
            
            $email = mysqli_real_escape_string($this->mysqli, $email);  
            $username = mysqli_real_escape_string($this->mysqli, $username);
            $password = mysqli_real_escape_string($this->mysqli, $password);  
            $first_name = mysqli_real_escape_string($this->mysqli, $first_name);
            $last_name = mysqli_real_escape_string($this->mysqli, $last_name);
            $middle_name = mysqli_real_escape_string($this->mysqli, $middle_name);

            $sql = "INSERT into accounts (email, username, password, first_name, last_name, middle_name, gid) VALUES ('$email', '$username', '$password', '$first_name', '$last_name', '$middle_name', 1)";
            
            if($query = $this->mysqli->prepare($sql)){
                $query->execute();
            }else{
                var_dump($this->mysqli->error);
            }
        }
        
        function check_login($username, $password)
        {
            $result = "0";
                                  
            $username = mysqli_real_escape_string($this->mysqli, $username);
            $password = mysqli_real_escape_string($this->mysqli, $password);
              
            $sql = "SELECT id FROM accounts WHERE username = '$username' AND password = '$password'";
            
            $result = mysqli_query($this->mysqli, $sql);
            $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
            $result = $row["id"];
            
            return $result;
        }
        
        function get_uid($username)
        {
                                
            $username = mysqli_real_escape_string($this->mysqli, $username);
              
            $sql = "SELECT id FROM users WHERE username = '$username'";
            
            if($query = $this->mysqli->prepare($sql)){
                $query->execute();
                $res = $query->get_result();
                $row = $res->fetch_assoc();
                
                $result = $row["id"];
            }else{
                var_dump($this->mysqli->error);
            }
            return $result;
        }

        function check_session($session, $uid, $ip)
        {
            $res = 0;

            $session = mysqli_real_escape_string($this->mysqli, $session); 
            $uid = mysqli_real_escape_string($this->mysqli,$uid); 
            $ip = mysqli_real_escape_string($this->mysqli, $ip);

            $sql = "SELECT id FROM sessions WHERE session = '$session' AND uid = '$uid' AND ip = '$ip'";

            $result = mysqli_query($this->mysqli, $sql);
            if (mysqli_num_rows($result) > 0)
            {
                $res = 1;
            }

            return $res;
        }

        function create_session($session, $uid, $ip)
        {
            $session = mysqli_real_escape_string($this->mysqli, $session); 
            $uid = mysqli_real_escape_string($this->mysqli, $uid); 
            $ip = mysqli_real_escape_string($this->mysqli, $ip);

            $sql = "INSERT INTO sessions (uid, session, ip) VALUES('$uid', '$session', '$ip')";

            if($query = $this->mysqli->prepare($sql)){
                $query->execute();
            }else{
                var_dump($this->mysqli->error);
            }

        }
        function get_account($uid)
        {
            $result;

            $sql = "SELECT * FROM accounts WHERE id = '$uid'";

            $result = mysqli_query($this->mysqli, $sql);
            $result = $result->fetch_assoc();

            return $result;
        }
        function delete_session()
        {

        }

        function send_request($uid, $quantity, $percents, $days, $phone)
        {
             
            $uid = mysqli_real_escape_string($this->mysqli, $uid); 
            $quantity = mysqli_real_escape_string($this->mysqli, $quantity);
            $percents = mysqli_real_escape_string($this->mysqli, $percents);
            $days = mysqli_real_escape_string($this->mysqli, $days);
            $phone = mysqli_real_escape_string($this->mysqli, $phone);

            $sql = "INSERT INTO requests (uid, quantity, percents, days, phone) VALUES('$uid', '$quantity', '$percents', '$days', '$phone')";

            if($query = $this->mysqli->prepare($sql)){
                $query->execute();
                return 1;
            }else{
                var_dump($this->mysqli->error);
            }
        }
        function send_payment($uid, $date, $payment, $secret)
        {
            $uid = mysqli_real_escape_string($this->mysqli, $uid); 
            $date = mysqli_real_escape_string($this->mysqli, $date);
            $payment = mysqli_real_escape_string($this->mysqli, $payment);
            $secret = mysqli_real_escape_string($this->mysqli, $secret);

            $sql = "INSERT INTO payments (uid, date, payment, secret) VALUES('$uid', '$date', '$payment', '$secret')";

            if($query = $this->mysqli->prepare($sql)){
                $query->execute();
                return 1;
            }else{
                var_dump($this->mysqli->error);
            }
        }
        function get_payments($uid)
        {
            $result;
            $res;
            $i = 0;
            $sql = "SELECT * FROM payments WHERE uid = '$uid'";

            $result = mysqli_query($this->mysqli, $sql);
            while ($row = $result->fetch_assoc()) {
                 $res[$i] = $row;
                 $i++;
            }

            if(empty($res))
            {
                $res = 0;
            }

            return $res;
        }
        function get_credits($uid)
        {
            $result;
            $res;
            $i = 0;
            $sql = "SELECT * FROM credits WHERE uid = '$uid'";

            $result = mysqli_query($this->mysqli, $sql);
            while ($row = $result->fetch_assoc()) {
                 $res[$i] = $row;
                 $i++;
            }
            if(empty($res))
            {
                $res = 0;
            }
            return $res;
        }

    }
?>