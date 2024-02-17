<?php

include 'connect.php';

 $login_web = $_POST['login_web'];
   
 $sql = "SELECT login FROM usuarios WHERE login='$login_web';";
 $result = mysqli_query($conexao,$sql);
 $num_rows = mysqli_num_rows($result);

 
 if ($num_rows == 1) {
 
     $sql = "DELETE FROM usuarios WHERE login = '$login_web';";
     $result = mysqli_query($conexao,$sql);
     echo $sql;
     mysqli_close($conexao);
     //echo "<br>New record created successfully";
     header('Location:comum.php?remocao=ok&user='.$login_web);
 }
 else{
     mysqli_close($conexao);
     header('Location:comum.php?remocao=fail&user='.$login_web);
 }
  
?>

