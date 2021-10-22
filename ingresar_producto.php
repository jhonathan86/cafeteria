<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>agregar producto</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>
    <div>
    <img id="imagen" src="img/titulo_panaderia.png" alt="imagen cabecera">
    </div>
    <div class=kyra>
     <center>
        <form action="agregarpro.php" method="POST" class="">
        <input placeholder="codigo producto" class="form-control" type="text" name="codigo_producto" id="copr" required><br>
        <input placeholder="nombre producto" class="form-control" type="text" name="nombre_producto" id="nom" required><br>
        <input placeholder="stock" class="form-control" type="text" name="stock" id="sto" required><br>
        <input placeholder="unidades disponibles" class="form-control" type="text" name="unidades_disponibles" id="unidis" required><br>
        <label for="">fecha de fabricacion</label>
        <input placeholder="fecha de fabricacion" class="form-control" type="date" name="fecha_de_fabricacion" id="fefa" required><br>
        <label for="">fecha de vencimiento</label>
        <input placeholder="fecha de vencimiento" class="form-control" type="date" name="fecha_de_vencimiento" id="feve" required><br>
        <button id="buttonj">Guardar</button>
        <a href="principal.php" id="buttonh">Atras</a><br>
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