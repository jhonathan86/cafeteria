<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<div>
    <img id="imagen" src="img/titulo_panaderia.png" alt="imagen cabecera">
</div>

<div>
    <center>
    <?php
        include_once "conexion.php";
        $sql="select * from tb_producto";
                //echo $sql;
        $resultado=$conexion->query($sql);
        echo "<table border='1' class='da'><tr><th>codigo_producto</th><th>nombre_producto</th><th>stock</th><th>unidades_disponibles</th><th>fecha_de_fabricacion</th><th>fecha_de_vencimiento</th></tr>";
        while($fila=mysqli_fetch_array($resultado))
        {
            echo "<tr><td>".$fila[0]."</td><td>".$fila[1]."</td><td>".$fila[2]."</td><td>".$fila[3]."</td><td>".$fila[4]."</td><td>".$fila[5]."</td></tr>";
        }
        echo "</table>";
    ?>
        <a href="principal.php" class="button">Atras</a>
    </center>
</div>
    
</body>
</html>