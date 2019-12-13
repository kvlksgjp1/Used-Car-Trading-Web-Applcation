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
	
	int engine_displacement_id=-1;
	String engine_displacement_name = request.getParameter("engine_displacement_name");
	System.out.println("새로운 배기량 입력 : " + engine_displacement_name);
	engine_displacement_name =engine_displacement_name.trim();
	System.out.println(engine_displacement_name);
	
	try {
		
		String sql = "select engine_displacement_id\r\n" + 
				"from engine_displacement\r\n" + 
				"where engine_displacement_name='"+engine_displacement_name+"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			engine_displacement_id = rs.getInt(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(engine_displacement_id==-1)
	{
		System.out.println("기존에 없던 배기량이라 새로 만듬");
		engine_displacement_id = get_number(conn, stmt, "engine_displacement");
		
		try {
			
			String sql = "INSERT INTO engine_displacement VALUES ("+engine_displacement_id+", '"+engine_displacement_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	try {
		String sql = "update vehicle set Vehicle_EID="+engine_displacement_id+" where vehicle_id="+vehicle_id;
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
		if (res>=0)
			System.out.println("업데이트 성공");
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 배기량 수정 완료 ("+engine_displacement_name+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
%>	
	
	
	</body>
</html>


