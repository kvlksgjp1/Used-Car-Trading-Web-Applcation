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
	
	String total_color = request.getParameter("total_color");
	total_color = total_color.trim();
	System.out.println(total_color);
	ArrayList<Integer> cids= new ArrayList<Integer>();
	String [] colors = {"init"};
	colors[0] = total_color;
	if (total_color.contains("+"))
		 colors = total_color.split("\\+");
	
	
	System.out.println("기존의 차량 색상을 검색합니다 : ");
	try {

		String sql = "select vehicle_color_cid\r\n" + 
				"from vehicle_color\r\n" + 
				"where vehicle_color_vid="+vehicle_id;
		System.out.println(sql);
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			cids.add(rs.getInt(1));
		}
		
		//res = stmt.executeUpdate(sql);
//		if (res>=0)
//			System.out.println("업데이트 성공");
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

	System.out.println("기존의 차량 색상을 제거합니다 : ");
	for (int i=0;i<cids.size();i++)
	{
		String sql = "DELETE FROM VEHICLE_COLOR \r\n" + 
				"WHERE vehicle_color_vid="+vehicle_id+" AND vehicle_color_cid="+cids.get(i); 
		try {
			res = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (res>=0)
			System.out.println("컬러 제거 성공");
		
	}
	
	
	for (int i=0; i<colors.length;i++)
	{
		int color_id=-1;
		try {
			String sql = "select color_id \r\n" + 
					"from color \r\n" + 
					"where color_name='"+colors[i]+"'";
			
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				color_id = rs.getInt(1);
			}
			
			if(color_id==-1)
			{
				System.out.println("기존에 없던 색상이라 새로 만듬");
				color_id = get_number(conn, stmt, "color");
				try {
					
					sql = "INSERT INTO COLOR VALUES ("+color_id+", '"+colors[i]+"')";
					System.out.println(sql);
					rs = stmt.executeQuery(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			sql = "INSERT INTO VEHICLE_COLOR VALUES ("+vehicle_id+", "+color_id+")";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	if(res>=1)
		out.write("<h2 align='center'>"+request.getParameter("vehicle_number")+"번 차량 색상 수정 완료 ("+total_color+")</h2>");

	out.write("<form align='center' method='post' action='index.html'>");
	out.write("<input align='right' type='submit' value='돌아가기'>");
	out.write(" </form>");
%>	
	
	
	</body>
</html>


