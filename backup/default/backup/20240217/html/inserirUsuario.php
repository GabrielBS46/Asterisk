<?php

include 'connect.php';

 $login_web = $_POST['login_web'];
 $senha_web = $_POST['senha_web'];
 $senha2_web = $_POST['senha2_web'];

 if ($senha_web == $senha2_web) {
	 
	$sql = "SELECT login FROM usuarios WHERE login='$login_web';";
	$result = mysqli_query($conexao,$sql);
	$num_rows = mysqli_num_rows($result);
	//echo $num_rows;

	if ($num_rows == 0) {
		// $senha = md5($senha_web);
		// $crip = password_hash($senha, PASSWORD_DEFAULT);

		$senha = password_hash($senha2_web,PASSWORD_DEFAULT);
		$sql = "INSERT INTO usuarios (login,password) values('$login_web','$senha');";
		$result = mysqli_query($conexao,$sql);
		mysqli_close($conexao);

		$msg = "NOERRO2";
		echo ok;
		//header('Location:comum.php?success=success&msg='.$login_web);

		//$content = http_build_query(array('msg' => $msg,));	
		//$context = stream_context_create(array('http'=>array('method'=>'POST','content'=>$content,)));
		//file_get_contents('comum.php', null, $context);

	}
	else{
		mysqli_close($conexao);
		$msg = "ERRO1";
		//header('Location:comum.php?success=success&msg='.$login_web);
		$content = http_build_query(array('msg' => $msg,));	
		$context = stream_context_create(array('http'=>array('method'=>'POST','content'=>$content,)));
		file_get_contents('comum.php', null, $context);
	}
 }else {
	mysqli_close($conexao);

	$dados = http_build_query(array(
		'status' => 'fail',
		'msg' => 'Nome duplicado'
		));

	$contexto = stream_context_create(array(
		'http' => array(
			'method' => 'POST',
			'content' => $dados,
			'header' => "Content-type: application/x-www-form-urlencoded\r\n"
			. "Content-Length: " . strlen($dados) . "\r\n",
		)
	));

	$resposta = file_get_contents('http://192.168.0.170/comum.php', null, $contexto);
	
}

?>

