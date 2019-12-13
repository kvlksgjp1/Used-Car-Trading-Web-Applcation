<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page language="java" import="java.text.*, java.sql.*, java.util.ArrayList" %>
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
	System.out.println("새로운 차량 연료 입력 (하이브리드면 '+' 로 구분) : ");
	
	String total_fuel = request.getParameter("total_fuel");
	total_fuel = total_fuel.trim();
	System.out.println(total_fuel);
	ArrayList<Integer> fids= new ArrayList<Integer>();
	String [] fuels = {"init"};
	fuels[0] = total_fuel;
	if (total_fuel.contains("+"))
		fuels = total_fuel.split("\\+");
	
	
	System.out.println("기존의 차량 연료를 검색합니다 : ");
	try {

		String sql = "select vehicle_fuel_Fid\r\n" + 
				"from vehicle_fuel\r\n" + 
				"where vehicle_fuel_vid="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			fids.add(rs.getInt(1));
		}
		
		//res = stmt.executeUpdate(sql);
//		if (res>=0)
//			System.out.println("업데이트 성공");
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

	System.out.println("기존의 차량 연료를 제거합니다 : ");
	for (int i=0;i<fids.size();i++)
	{
		String sql = "DELETE FROM VEHICLE_FUEL \r\n" + 
				"WHERE vehicle_fuel_vid="+vehicle_id+" AND vehicle_fuel_fid="+fids.get(i); 
		try {
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (res>=0)
			System.out.println("컬러 제거 성공");
	}
	
	
	for (int i=0; i<fuels.length;i++)
	{
		int fuel_id=-1;
		try {
			String sql = "select fuel_id \r\n" + 
					"from fuel \r\n" + 
					"where fuel_name='"+fuels[i]+"'";
			
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				fuel_id = rs.getInt(1);
			}
			
			if(fuel_id==-1)
			{
				System.out.println("기존에 없던 연료라서 새로 만듬");
				fuel_id = get_number(conn, stmt, "fuel");
				try {
					
					sql = "INSERT INTO FUEL VALUES ("+fuel_id+", '"+fuels[i]+"')";
					System.out.println(sql);
					rs = stmt.executeQuery(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			sql = "INSERT INTO VEHICLE_FUEL VALUES ("+vehicle_id+", "+fuel_id+")";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 연료 수정 완료 ("+total_fuel+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
%>	
	
	
	</body>
</html>


