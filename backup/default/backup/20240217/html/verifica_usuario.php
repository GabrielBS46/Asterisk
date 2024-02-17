<?php

include 'connect.php';
 
 $usuario = $_POST['usuario'];
 $senha = $_POST['senha'];
 //verifica usuario
 $sql = "SELECT * FROM usuarios WHERE login = '$usuario'";
 $busca = mysqli_query($conexao, $sql);		// Busca a conexão da tabela
 $linha = mysqli_affected_rows($conexao);	// Verificar se exite somente 1 usuario

 mysqli_close($conexao);

 if ($linha == 1) { //exixte usuario entao vai comparar a senha

	//Trata infos do DB num array
	$dados = mysqli_fetch_array($busca);
	//$userRecebido = $dados['usuario'];
	$senhabd = $dados['password'];
	//$senhaVerificada = md5($senha);
   
    //if ($senhabd == $senhaVerificada){
	if (password_verify($senha, $senhabd)) {
		session_start();
         $_SESSION['usuario'] = $usuario;
         header ('Location: home.php');
    } else {     
        header('Location:index.php?status=senhaInvalida');
    }
 } else {
     //echo 'Usuario inexistente';
    header ('Location:index.php?status=senhaInvalida');
 }

?>
