<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE HTML>
<!--
	Dimension by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<%!
int get_number(Connection conn, Statement stmt, String table) {

		ResultSet rs = null;
		int return_num = -1;
		
		try {
			
			String sql = "select count(*)\r\n" + 
					"from "+table;
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				return_num = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return return_num;
		
	}
%>

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
	Statement stmt = conn.createStatement();
	String vehicle_id=request.getParameter("vehicle_number");
	int category_id=-1;
	int res=-1;
	
	int transmission_id=-1;
	System.out.println("새로운 변속기 입력 : ");
	String transmission_name = request.getParameter("transmission_name");
	transmission_name = transmission_name.trim();
	System.out.println(transmission_name);
	
	try {
		
		String sql = "select transmission_id\r\n" + 
				"from transmission\r\n" + 
				"where transmission_name='"+transmission_name+"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			transmission_id = rs.getInt(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(transmission_id==-1)
	{
		System.out.println("기존에 없던 변속기라 새로 만듬");
		transmission_id = get_number(conn, stmt, "TRANSMISSION");
		
		try {
			
			String sql = "INSERT INTO TRANSMISSION VALUES ("+transmission_id+", '"+transmission_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	try {
		String sql = "update vehicle set Vehicle_TID="+transmission_id+" where vehicle_id="+vehicle_id;
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 차종 변속기 수정 완료 ("+transmission_name+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
	%>	
	
	
	</body>
</html>


