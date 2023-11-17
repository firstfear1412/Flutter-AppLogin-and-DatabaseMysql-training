<?php
require "connect.php";
$sql = "SELECT * FROM img ORDER BY id DESC";
$img_db = mysqli_query($con,$sql);
$lsit  = array();
while($rowdata = $img_db->fetch_assoc()){
    $list[] = $rowdata;
}
echo json_encode($list);
?>