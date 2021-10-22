<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insertar persona</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<div>
    <img id="imagen" src="img/titulo_panaderia.png" alt="imagen cabecera">
</div>
<div class="kyra">
    <center>
     <form action="agregar.php" method="POST" class="was-validated">
        <input placeholder="cedula" class="form-control" type="text" name="cedula" id="ced" required><br>
        <input placeholder="Nombre" class="form-control" type="text" name="nombre" id="nombre" required><br>
        <input placeholder="apellido" class="form-control" type="text" name="apellido" id="apellido" required><br>
        <input placeholder="telefono" class="form-control" type="text" name="telefono" id="telefono" required><br>
        <button id="ba">Guardar</button>
        <a href="principal.php" id="bb">Atras</a><br>
    </form>
    </center>
</div>
<?php
if(isset($_GET['v1'])){
   if($_GET['v1']==0)
    {
        echo"La persona que trata de ingresar ya existe en la base de datos";
    } 
    else
    {
        echo"La persona se ingreso satisfactoriamente";
    } 
}
?>
</body>
</html>