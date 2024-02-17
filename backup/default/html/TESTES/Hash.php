<?php

 $senha = 456;    // Definindo valor de testes
 echo $senha . "<br>";

 $crip = password_hash($senha, PASSWORD_DEFAULT);  // Criando hash com salt
 echo $crip . "<br>";

 if (password_verify($senha, $crip)) {             // Verificando senha com hash e salt
    echo 'Password is valid!';
 } else {
    echo 'Invalid password.';
 }

?>