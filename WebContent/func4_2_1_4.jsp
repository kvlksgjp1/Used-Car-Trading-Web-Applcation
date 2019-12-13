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
	String category_name=request.getParameter("category_name");
	
	category_name = category_name.trim();
	System.out.println(category_name);
	int category_id=-1;
	int res=-1;
	try {
		
		String sql = "select category_id\r\n" + 
				"from category\r\n" + 
				"where category_name='"+category_name+"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			category_id = rs.getInt(1);
		}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(category_id==-1)
	{
		System.out.println("기존에 없던 카테고리라 새로 만듬");
		category_id = get_number(conn, stmt, "category");
		try {
			
			String sql = "INSERT INTO CATEGORY VALUES ("+category_id+", '"+category_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//INSERT INTO CATEGORY VALUES (변수_id, '넣고싶은값');
		//System.out.println(get_number(conn, stmt, "category"));
	}
	try {

		String sql = "update vehicle set Vehicle_CID="+category_id+" where vehicle_id="+vehicle_id;
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 차종 수정 완료 ("+category_name+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
	%>	
	
	
	</body>
</html>


