<?php
    include 'api/Cryptography_Class.php';
    include 'api/API.php';
    
    if (API::issetParam("ciphertext")) $ciphertext = API::getParam("ciphertext");
    //echo $ciphertext;
    //echo "<br/><br/><br/>";    
    $ciphertext="Z5ovARDgk3EaMjQoZC9vnUD0mPhGYq04XOS9UKqcFjxwX6o1lAn8vVEeTW8izb+RrQ8o76UfWmEjlbb3YNkR2c00YhSoNDpzo/xoAlnMmVP72mJniQlLbnHOLo2ZCS1BG2xa00oz3Ed7la+5jmVo1mRvoMwpjp5VLG9I63Xahvs=";
    $ciphertext = base64_decode($ciphertext);
    //$ciphertext = hex2bin($ciphertext);
    
    $key = "1234567890"; 
    $data = "";
    $mode = "cbc";
    
    //mcrypt_decrypt ($ciphertext, $key, $data, $mode);
    //echo $data;
    
    
    echo "Original cipher: ".$ciphertext;
    echo "<br/><br/><br/>";

      
    //N/7kieYygJBaCZGfiM/lBCNUOrIR6dyfczVV66X9jKxx4zrCpW0zw8eX24jAbSl238JOqVEDIH+dp4B13QrXvV+newHSSGe83gf7ReGSqe+enz1ExuHWCTm/KCYw2Dy/onwPaX/YmK64UCmcwC+lYU6dbDqr/opXdaE7TQB0ces=
    
    //EWBgJfzaXRG03fd+fcxjI3VXfyAJD/pD+1q9WV1RKIxFHP85LA5RxvisPpTD1RQ4lpUYOUH1+5SepcaIgp9g4+x8GL+RxosbuegdUYivnBbYd18oZATNNjdjfzykWQ64PIMQxLL0Z67rELkv8zgYyQ7+uHlZCil/rhhoTouLsjY=
    
    $plaintext = Cryptography_Class::decrypt($ciphertext);
    //$plaintext = implode("UTF-8", $plaintext);
    
    echo "Decoded cipher: ".$plaintext;
    echo "<br/><br/><br/>";
    
    $plaintext1 = base64_decode($plaintext);
    echo "Decoded: ".$plaintext1;
    echo "<br/><br/><br/>";
   
    
    //echo "<br/><br/><br/>";
    //print_r($plaintext);
    //echo "<br/><br/><br/>";
    //echo $ciphertext;
    $test = Cryptography_Class::encrypt("Hello kitty");
    echo "Encoded: ".$test;
    echo "<br/><br/><br/>";
    
    $test = Cryptography_Class::decrypt($test);
    echo "Decoded: ".$test;
    echo "<br/><br/><br/>";
?>