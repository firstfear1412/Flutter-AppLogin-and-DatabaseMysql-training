<?php
require "connect.php";
if(isset($_POST["insert"])){
    //ชื่อไฟล์ต้นฉบับ
    $image = $_FILES['image']['name'];
    $name = $_POST["name"];

    $imagePath = 'uploads/'.$image;
    $tmp_name = $_FILES['image']['tmp_name'];

    move_uploaded_file($tmp_name,$imagePath);

    $con->query("INSERT INTO img(name,image)VALUES('$name','$image')");
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>image_upload</title>
</head>
<body>
    <form method="POST" enctype="multipart/form-data">
        <input type="file" name="image">
        <input type="text" name="name">
        <input type="submit" name="insert">
    </form>
</body>
</html>