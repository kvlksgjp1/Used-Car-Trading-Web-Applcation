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
	

	int make_id=-1;
	System.out.println("새로운 제조사 입력 : ");
	
	String make_name = request.getParameter("make");
	make_name =make_name.trim();
	System.out.println(make_name);
	
	try {
		
		String sql = "select Make_ID  \r\n" + 
				"from make\r\n" + 
				"where Make_Name  ='"+make_name +"'";
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
	
	if(make_id==-1)
	{
		System.out.println("기존에 없던 제조사라 새로 만듬");
		make_id = get_number(conn, stmt, "make");
		
		System.out.println("이 제조사의 국내/해외 여부 입력");
		String make_location = request.getParameter("make_location");
		make_location = make_location.trim();
		System.out.println(make_location);	

		String sql = "INSERT INTO make VALUES ("+make_id+", '"+make_name+"', '"+make_location+"')";
		System.out.println(sql);
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	String org_model = "none";
	String org_dmodel = "none2";
	
	System.out.println("기존의 모델명과, 세부모델명 검색");
	

	try {
		
		String sql = "select Vehicle_ModelID \r\n" + 
				"from vehicle\r\n" + 
				"where vehicle_id="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			org_model = rs.getString(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	System.out.println("쿼리로 받아온 현재  모델명 : " + org_model);
	
	try {
		
		String sql = "select Vehicle_DID \r\n" + 
				"from vehicle\r\n" + 
				"where vehicle_id="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			org_dmodel = rs.getString(1);
		}
		rs.close();
	System.out.println("쿼리로 받아온 현재  세부모델명 : " + org_dmodel);
	
	System.out.println(org_model +"//"+ org_dmodel);

	int num_of_model=-1;
	
	String sql3 = "select model_mid \r\n" + 
			"from model\r\n" + 
			"where Model_MID="+make_id +" AND Model_Name='"+org_model+"'";
	System.out.println(sql3);
	rs = stmt.executeQuery(sql3);
	
	while(rs.next()) {
		num_of_model = rs.getInt(1);
	}
	
	if(num_of_model==-1)
	{
		sql = "INSERT INTO model VALUES ("+make_id+", '"+org_model+"')";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
	}
	
	//이제 세부모델
	
	int num_of_dmodel=-1;
	sql = "select detailed_model_mid \r\n" + 
			"from detailed_model\r\n" + 
			"where Detailed_Model_MID ="+make_id +" AND Detailed_Model_Mname='"+org_model +"' AND Detailed_Model_Name ='"+org_dmodel+"'";
	System.out.println(sql);
	rs = stmt.executeQuery(sql);
	
	while(rs.next()) {
		num_of_dmodel = rs.getInt(1);
	}
	
	if(num_of_dmodel==-1)
	{
		sql = "INSERT INTO detailed_model VALUES ("+make_id+", '"+org_model+"', '"+org_dmodel+"')";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
	}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	try {
		String sql = "update vehicle set Vehicle_MakeID ="+make_id+" where vehicle_id="+vehicle_id;
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
		if (res>=0)
			System.out.println("업데이트 성공");
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 배기량 제조사 수정 완료 ("+make_name+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
%>	
	
	
	</body>
</html>


