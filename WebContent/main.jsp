<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322: Introduction to Databases</title>
</head>
<body>
	<h2>Lab #8</h2>
	<h3>:: JSP Practice ::</h3>
	<h4>GET and POST Methods to Read From Data</h4>
	<form action="getData.jsp" method="POST">
		<h4>Provide your information.</h4>
		StudentID: <input type="text" name="sID">
		<br />
		Frist Name: <input type="text" name="first_name">
		<br />
		Last Name: <input type="text" name="last_name" />
		<br />
		<h4>Select with section you are taking:</h4>
		
		<input type="checkbox" name="course" value="COMP322001"/>COMP322001
		<input type="checkbox" name="course" value="COMP322002"/>COMP322002
		<input type="checkbox" name="course" value="COMP322003"/>COMP322003
		<input type="checkbox" name="course" value="COMP322004"/>COMP322004
		<input type="checkbox" name="course" value="none" checked="checked"/>Nothing
		<input type="submit" value="Submit"/>

	</form>
</body>
</html>