<link rel="stylesheet" href="css/estilos.css">
<div class="container">
<?php
include_once "conexion.php";
$cedula= $_POST["cedula"];
$nombre = $_POST["nombre"];
$apellido=$_POST["apellido"];
$telefono=$_POST["telefono"];
$valores= "'".$cedula ."','". $nombre ."','".$apellido."','".$telefono."'";
/*$sql="INSERT INTO tb_clientes(cedula_clientes,nombre,apellido,telefono) VALUES($valores)";*/


$sql="Call spclientes($valores,@rta);";

$resultado=$conexion->query($sql);

while($fila=mysqli_fetch_array($resultado))
{
   
   if($fila[0]==0)
   {
      echo "<script>
      window.location.href='agregar_clientes.php?v1=0'
      </script>";   
   }
   else
   {
      echo "<script>
      window.location.href='agregar_clientes.php?v1=1'
      </script>";
   }
   
}

?>

</div>