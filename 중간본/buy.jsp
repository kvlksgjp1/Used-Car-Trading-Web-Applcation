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
	<h2 align="center">구매 해 주셔서 감사합니다.</h2><br>
	<span style="float:center">
	<form align="center"><input type="button" value="돌아가기" onclick="location.href='index.html'"></form>
	</span><br>
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
	String user_id = request.getParameter("uid");
	String v_id = request.getParameter("vid");
	SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd");
	String date = f1.format(System.currentTimeMillis());
	String sql = "insert into order_ values(" + "'"+user_id+"',"+"'"+ v_id+"',"+"'"+date+"')"; 
	System.out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	%>
	
	</body>
</html>
