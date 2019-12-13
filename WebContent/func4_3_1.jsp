<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE HTML>
<!--
	Dimension by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Dimension by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body>
	<br><br><br>
	
	<br><br>
	<%
	String ip = "localhost";
	String strSID = "xe";
	String portNum = "1600";
	String user = "team_project";
	String pass = "team";
	String url = "jdbc:oracle:thin:@"+ip+":"+portNum+":"+strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);

	String year=request.getParameter("year");

	String sql = "update vehicle set is_opened=1 where vehicle_id="+request.getParameter("vehicle_number");
	System.out.println(sql);
	Statement stmt = conn.createStatement();
	int res = stmt.executeUpdate(sql);
	
	if(res==1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"차량 공개 처리 완료</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
	%>	
	
	
	</body>
</html>


