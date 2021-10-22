<link rel="stylesheet" href="css/estilos.css">
<div class="container">
<?php
include_once "conexion.php";
$codpro= $_POST["codigo_producto"];
$nompro = $_POST["nombre_producto"];
$sto=$_POST["stock"];
$unidis=$_POST["unidades_disponibles"];
$fefa=$_POST["fecha_de_fabricacion"];
$feva=$_POST["fecha_de_vencimiento"];
$valores= "'".$codpro ."','". $nompro ."','".$sto."','".$unidis."','".$fefa."','".$feva."'";
/*$sql="INSERT INTO tb_clientes(cedula_clientes,nombre,apellido,telefono) VALUES($valores)";*/


$sql="Call spprod($valores,@rta);";

$resultado=$conexion->query($sql);

while($fila=mysqli_fetch_array($resultado))
{
   
   if($fila[0]==0)
   {
      echo "<script>
      window.location.href='ingresar_producto.php?v1=0'
      </script>";   
   }
   else
   {
      echo "<script>
      window.location.href='ingresar_producto.php?v1=1'
      </script>";
   }
   
}

?>

</div>