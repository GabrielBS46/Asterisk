<?php
include 'comum.php';

?>

<html>
	<body>    
		
		<div class=" ">
		<div class="row">
			<div class="container col-sm-12 col-md-8">
				<form action="inserirUsuario.php" method="POST">
					<div class="form-group col-sm-12 col-md-12">
						<label  class="mt-5" for="">Nome do usuário</label>
						<input name="login_web" type="text" class="form-control" id=""  placeholder="" autofocus required>
						<small  class="form-text text-muted">Login do usuário.</small>
				   
						<label for="">Senha :</label>
						<input name="senha_web" type="password" class="form-control" id=""  placeholder=""  required >
						<small  class="form-text text-muted">Digite aqui senha.</small>
					
						<label for="">Confirme sua senha :</label>
						<input name="senha2_web" type="password" class="form-control" id=""  placeholder=""  required >
						<small  class="form-text text-muted">Digite novamente aqui senha.</small>
	   
						<button type="submit" class="mt-2 btn btn-primary col-sm-12 col-md-12">Submit</button>
				  </div>
						
				</form>
			</div>
			
		</div>
		</div>
		
	</body>
</html>