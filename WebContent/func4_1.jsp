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
	<h2 align="center">Vehicle Registration</h2>	
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
	int vehicle_id = -1;
	int category_id = -1;
	int transmission_id = -1;
	int engine_displacement_id = -1;
	int model_id = -1;
	int detailed_model_id = -1;
	int make_id = -1;
	int price=-1;
	int mileage=-1;
	String model_year;
	
	vehicle_id = get_number(conn, stmt, "vehicle");
	
	price = Integer.parseInt(request.getParameter("price"));
	
	mileage = Integer.parseInt(request.getParameter("mileage"));
	
	model_year = request.getParameter("model_year");
	
	String category_name = request.getParameter("category_name");
	category_name = category_name.trim();
	System.out.println(category_name);
	
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
		System.out.println("������ ���� ī�װ��� ���� ����");
		category_id = get_number(conn, stmt, "category");
		try {
			
			String sql = "INSERT INTO CATEGORY VALUES ("+category_id+", '"+category_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//INSERT INTO CATEGORY VALUES (����_id, '�ְ������');
		//System.out.println(get_number(conn, stmt, "category"));
	}
	
	System.out.println("�ְ���� ���ӱ�  : ");
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
		System.out.println("������ ���� ���ӱ�� ���� ����");
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
	
	System.out.println("�ְ���� ��ⷮ  : ");
	String engine_displacement_name = request.getParameter("engine_displacement_name");
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
		System.out.println("������ ���� ��ⷮ�̶� ���� ����");
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
	
	
	System.out.println("�ְ���� ������  : ");
	String make_name = request.getParameter("make_name");
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
		System.out.println("������ ���� ������� ���� ����");
		make_id = get_number(conn, stmt, "make");
		
		System.out.println("�� �������� ����/�ؿ� ���� �Է�");
		String make_location = request.getParameter("make_location");
		make_location = make_location.trim();
		System.out.println(make_location);
		
		try {
			
			String sql = "INSERT INTO make VALUES ("+make_id+", '"+make_name+"', '"+make_location+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	String model_name = request.getParameter("model_name");
	model_name =model_name.trim();
	System.out.println(model_name);
	
	try {
		
		String sql = "select model_mid  \r\n" + 
				"from model\r\n" + 
				"where model_mid="+make_id+" AND model_Name='"+model_name +"'";
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
		
		try {
			
			String sql = "INSERT INTO model VALUES ("+make_id+", '"+model_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	System.out.println("�ְ���� ���� ��  : ");
	String detailed_model_name = request.getParameter("detailed_model_name");
	detailed_model_name =detailed_model_name.trim();
	System.out.println(detailed_model_name);
	
	try {
		
		String sql = "select detailed_model_mid  \r\n" + 
				"from detailed_model\r\n" + 
				"where detailed_model_mid="+make_id+" AND Detailed_Model_Mname ='"+model_name +"' AND Detailed_Model_Name='"+detailed_model_name+"'";
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
		System.out.println("������ ���� ���� ���̶� ���� ����");
		
		try {
			
			String sql = "INSERT INTO detailed_model VALUES ("+make_id+", '"+model_name+"', '"+detailed_model_name+"')";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	System.out.println("���� ����"); //foreign key ������, �ν��Ͻ��� ���⼭ ���� ���Ŀ�, ����, ���Ḧ ������.
	
	try {

		String sql = "INSERT INTO VEHICLE VALUES ("+vehicle_id+", "+price+", "+mileage+", TO_DATE('"+model_year+"', 'yyyy-mm-dd'), "+category_id+", "+transmission_id+", "+engine_displacement_id+", "+make_id+", '"+ model_name+"', '"+detailed_model_name+"', 1)";                           
		out.write("<h4 align='center'>"+sql+"</h2>");
		out.write("<h2 align='center'>\n������ ��ϵǾ����ϴ�\n</h2>");
		out.write("<h3 align='center'>���� ���� ID : "+vehicle_id+"</h2>");
		

		out.write("<form align='center' method='post' action='index.html'>");
		out.write("<input align='right' type='submit' value='���ư���'>");
		out.write(" </form>");
		
		rs = stmt.executeQuery(sql);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	System.out.println("�Ϸ�");
	
	System.out.println("�ְ����  ���� (�����̸� + �� �и�)  : ");
	String total_color = request.getParameter("total_color");
	total_color =total_color.trim();
	System.out.println(total_color);
	
	String [] colors= total_color.split("\\+");
	
	for (int i=0; i<colors.length;i++)
	{

		int color_id=-1;
		
		try {
			
			String sql = "select color_id  \r\n" + 
					"from color\r\n" + 
					"where color_name='"+colors[i]+"'";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				color_id = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(color_id==-1)
		{
			System.out.println("������ ���� ���� �̶� ���� ����");
			color_id = get_number(conn, stmt, "color");
			
			
			try {
				
				String sql = "INSERT INTO color VALUES ("+color_id+", '"+colors[i]+"')";
				
				System.out.println(sql);
				rs = stmt.executeQuery(sql);
				

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		String sql = "INSERT INTO vehicle_color VALUES ("+vehicle_id+", "+color_id+")";
		System.out.println(sql);
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	System.out.println("�ְ����  ���� (���̺긮��� + �� �и�)  : ");
	String total_fuel = request.getParameter("total_fuel");
	total_fuel =total_fuel.trim();
	System.out.println(total_fuel);
	
	String [] fuels= total_fuel.split("\\+");
	
	for (int i=0; i<fuels.length;i++)
	{
		int fuel_id=-1;
		
		try {
			
			String sql = "select fuel_id  \r\n" + 
					"from fuel\r\n" + 
					"where fuel_name='"+fuels[i]+"'";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				fuel_id = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(fuel_id==-1)
		{
			System.out.println("������ ���� ����� ���� ����");
			fuel_id = get_number(conn, stmt, "fuel");
			
			try {
				
				String sql = "INSERT INTO fuel VALUES ("+fuel_id+", '"+fuels[i]+"')";
				System.out.println(sql);
				rs = stmt.executeQuery(sql);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		

		String sql = "INSERT INTO vehicle_fuel VALUES ("+vehicle_id+", "+fuel_id+")";
		System.out.println(sql);
		
		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	%>	
	
	
	</body>
</html>
