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
	
	int model_id=-1;
	System.out.println("���ο� �� �Է� : ");
	
	String model_name = request.getParameter("model");
	model_name =model_name.trim();
	System.out.println(model_name);
	
	int model_mid=-1;
	try {
		
		String sql = "select Vehicle_MakeID \r\n" + 
				"from vehicle\r\n" + 
				"where vehicle_id="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			model_mid = rs.getInt(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	System.out.println("������ �޾ƿ� ���� ������ ID : " + model_mid);
	
	
	String org_dmodel = null;
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
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	System.out.println("������ �޾ƿ� ����  ���θ𵨸� : " + org_dmodel);

	try {
		
		String sql = "select model_mid  \r\n" + 
				"from model\r\n" + 
				"where model_mid="+model_mid+" AND model_Name='"+model_name +"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			model_id = rs.getInt(1);
		}
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(model_id==-1)
	{
		System.out.println("������ ���� ���̶� ���� ����");
		model_id =get_number(conn, stmt, "model");
		try {
			
			String sql = "INSERT INTO model VALUES ("+model_mid+", '"+model_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	try {
		int num_of_dmodel=-1;
		String sql = "select Detailed_Model_Mid \r\n" + 
				"from detailed_model\r\n" + 
				"where Detailed_Model_MID ="+model_mid +" AND Detailed_Model_Mname='"+model_name +"' AND Detailed_Model_Name ='"+org_dmodel+"'";
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			num_of_dmodel = rs.getInt(1);
		}
		
		if(num_of_dmodel==-1)
		{
			System.out.println("foreign key ���� �ذ� ���� ���ο� ���θ� ����.");
			sql = "INSERT INTO detailed_model VALUES ("+model_mid+", '"+model_name+"', '"+org_dmodel+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	try {
		String sql = "update vehicle set Vehicle_ModelID='"+model_name+"' where vehicle_id="+vehicle_id;
		System.out.println(sql);
		res = stmt.executeUpdate(sql);
		
		if (res>=0)
			System.out.println("������Ʈ ����");
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"�� ���� �� ���� �Ϸ� ("+model_name+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='���ư���'>");
	out.write(" </form>");
%>	
	
	
	</body>
</html>


