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
	<h2 align="center">My Recommendation List</h2>	
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
	
	String sql_1="select count(*) from order_ where order_aid='"+request.getParameter("login_id")+"'";
	System.out.println(sql_1);
	pstmt = conn.prepareStatement(sql_1);
	int test=0;
	rs = pstmt.executeQuery();
	while(rs.next()){
		test=rs.getInt(1);
	}
	
	if(test>=1)
	{
		out.write("<h2 align='center'>"+request.getParameter("login_id")+"고객님은 차량 구매 이력이 있습니다</h2>");
	}
	else{
			String sql="with target_ as(\r\n" + 
					"select SUBSTR(TO_CHAR(Bdate, 'YY'),0,1) as bd, Sex as s from account where Account_id='"+request.getParameter("login_id")+"'\r\n" + 
					"),target_vehicle as(\r\n" + 
					"select *\r\n" + 
					"from order_ JOIN Account ON(Order_AID=Account_id) JOIN Vehicle on(order_vid=vehicle_id) JOIN target_ ON Sex=target_.s\r\n" + 
					"WHERE SUBSTR(TO_CHAR(Bdate, 'YY'),0,1)=target_.bd)\r\n" + 
					", most_price_total as(\r\n" + 
					"select floor(price/1000)*1000 as m_price, count(*) as ct\r\n" + 
					"from target_vehicle\r\n" + 
					"group by floor(price/1000)*1000\r\n" + 
					"), most_price as( select *\r\n" + 
					"from most_price_total\r\n" + 
					"where ct=(Select max(ct) from most_price_total))\r\n" + 
					", most_category_total as( --최빈 차종\r\n" + 
					"select count(*) ct2, vehicle_cid as m_category\r\n" + 
					"from target_vehicle\r\n" + 
					"group by vehicle_cid)\r\n" + 
					",most_category as(\r\n" + 
					"select m_category\r\n" + 
					"from most_category_total\r\n" + 
					"where ct2 = (select max(ct2) from most_category_total)\r\n" + 
					"), most_transmission_total as( --변속기\r\n" + 
					"select count(*) ct2, vehicle_tid as m_transmission\r\n" + 
					"from target_vehicle\r\n" + 
					"group by vehicle_tid)\r\n" + 
					",most_transmission as(\r\n" + 
					"select m_transmission\r\n" + 
					"from most_transmission_total\r\n" + 
					"where ct2 = (select max(ct2) from most_transmission_total)\r\n" + 
					"), most_engine_displacement_total as( --배기량\r\n" + 
					"select count(*) ct3, vehicle_eid as m_engine_displacement\r\n" + 
					"from target_vehicle\r\n" + 
					"group by vehicle_eid)\r\n" + 
					",most_engine_displacement as(\r\n" + 
					"select m_engine_displacement\r\n" + 
					"from most_engine_displacement_total\r\n" + 
					"where ct3 = (select max(ct3) from most_engine_displacement_total)\r\n" + 
					"), most_make_total as( --제조사\r\n" + 
					"select count(*) ct2, vehicle_makeid as m_make\r\n" + 
					"from target_vehicle\r\n" + 
					"group by vehicle_makeid)\r\n" + 
					",most_make as(\r\n" + 
					"select m_make\r\n" + 
					"from most_make_total\r\n" + 
					"where ct2 = (select max(ct2) from most_make_total)\r\n" + 
					")select vehicle_id,vehicle_did,price,mileage,price,model_year --가격까지 완료\r\n" + 
					"from vehicle, most_price, most_make, most_category, most_transmission, most_engine_displacement\r\n" + 
					"where price between most_price.m_price and most_price.m_price+1000\r\n" + 
					"AND vehicle_cid=most_category.m_category\r\n" + 
					"AND vehicle_tid=most_transmission.m_transmission\r\n" + 
					"AND vehicle_Eid=most_engine_displacement.m_engine_displacement\r\n" + 
					"AND vehicle_makeid=most_make.m_make";
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
		String str = rs.getString(6);
		out.println("<td>"+str.split(" ")[0]+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	}
	%>	
	
	</body>
</html>
