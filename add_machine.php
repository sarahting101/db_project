<?php //==** check if the user has login or not / if push the logout button what will happen ==**//
    session_start();

?>

<!DOCTYPE html>
<html>
<head>
	<title>線上扭蛋機</title>
		<meta http-equiv="Content-Type" content="text/css; charset=utf-8">
    <link rel="stylesheet" href="style.css?v=<?php echo time(); ?>">
</head>
<body>
	<h1 align='center'>增加扭蛋機</h1>
	<table width="500" border="1" bgcolor="#cccccc" align="center">
		<tr>
			<th>扭蛋機名稱</th>
			<td bgcolor="#FFFFFF"><input type="text" name="machine_id" /></td>
		</tr>
		<tr>
			<th>售價</th>
			<td bgcolor="#FFFFFF"><input type="text" name="price"  /></td>
		</tr>
		<tr>
			<th>扭蛋機圖片連結</th>
			<td bgcolor="#FFFFFF"><input type="text" name="picture" /></td>
		</tr>
		
	</table>
    <form action="ehome.php"><input type="submit" value="返回"></form>
</body>
	
</html>
    