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
	<h2 align="center">A List of Vehicle</h2>
	<span style="float:right"><input type="button" value="돌아가기" onclick="location.href='index.html'"></span><br>
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
	String vid = request.getParameter("vid");
	String sql = "select distinct vehicle_id,price,mileage,model_year,vehicle_modelid,vehicle_did,category_name,transmission_name,engine_displacement_name,fuel_name,color_name\r\n" + 
			"from vehicle,category,transmission,engine_displacement,vehicle_fuel,fuel,vehicle_color,color,detailed_model\r\n" + 
			"where vehicle_cid = category_id and vehicle_tid = transmission_id and vehicle_eid = engine_displacement_id\r\n" + 
			"and vehicle_makeid = detailed_model_mid and vehicle_id = vehicle_fuel_vid and vehicle_id = vehicle_color_vid  \r\n" + 
			"and vehicle_modelid = detailed_model_mname and vehicle_did = detailed_model_name and vehicle_fuel_fid = fuel_id\r\n" + 
			"and vehicle_color_cid = color_id and vehicle_id = "+ vid;
	System.out.println(sql);
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	out.println("<table border = \"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		
		
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("<td>"+rs.getString(4)+"</td>");
		out.println("<td>"+rs.getString(5)+"</td>");
		out.println("<td>"+rs.getString(6)+"</td>");
		out.println("<td>"+rs.getString(7)+"</td>");
		out.println("<td>"+rs.getString(8)+"</td>");
		out.println("<td>"+rs.getString(9)+"</td>");
		out.println("<td>"+rs.getString(10)+"</td>");
		out.println("<td>"+rs.getString(11)+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	%>
	<br><br>
	<form method="post" action="buy.jsp">
	(아래는 차량 구매 시 필수 입력사항 입니다.)<br>
	사용자 아이디<input type="text" name="uid"><br>
	차량 아이디<input type="text" name="vid"><br>
	<input type="submit" value="구매">
	</form>
	
	</body>
	
	
</html>
