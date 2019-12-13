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
	
	int detailed_model_id=-1;
	System.out.println("새로운 세부 모델 입력 : ");
	
	String detailed_model_name = request.getParameter("detailed_model_name");
	detailed_model_name = detailed_model_name.trim();
	System.out.println(detailed_model_name);
	
	int make_id=-1;
	try {
		
		String sql = "select Vehicle_MakeID \r\n" + 
				"from vehicle\r\n" + 
				"where vehicle_id="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			make_id = rs.getInt(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	System.out.println("쿼리로 받아온 현재 제조사 ID : " + make_id);

	String model_id=null;
	try {
		
		String sql = "select Vehicle_ModelID \r\n" + 
				"from vehicle\r\n" + 
				"where vehicle_id="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			model_id = rs.getString(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	System.out.println("쿼리로 받아온 현재 모델 ID : " + model_id);

	try {
		
		String sql = "select detailed_model_mid  \r\n" + 
				"from detailed_model\r\n" + 
				"where detailed_model_mid="+make_id+" AND detailed_model_Mname='"+model_id +"'" + " AND Detailed_Model_Name='"+detailed_model_name +"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			detailed_model_id = rs.getInt(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(detailed_model_id==-1)
	{
		System.out.println("기존에 없던 세부 모델이라 새로 만듬");
		
		try {
			
			String sql = "INSERT INTO detailed_model VALUES ("+make_id+", '"+model_id+"', '"+detailed_model_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	try {
		String sql = "update vehicle set Vehicle_DID='"+detailed_model_name+"' where vehicle_id="+vehicle_id;
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
		if (res>=0)
			System.out.println("업데이트 성공");
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 세부모델 수정 완료 ("+detailed_model_name+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
%>	
	
	
	</body>
</html>


