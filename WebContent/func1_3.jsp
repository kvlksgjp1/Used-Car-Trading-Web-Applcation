<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!--  import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>

<%
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1600";
	String user = "team_project";
	String pass = "team";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;	
	
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();
	
	String query ="update account set password="+"'"+request.getParameter("newpassword")+"'"+ "where account_id ="+"'"+request.getParameter("id")+"'";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	try{
		rs = pstmt.executeQuery();
		String redirectUrl = "index.html?"+"change_status=success"; //
		response.sendRedirect(redirectUrl);
	}catch(Exception e)
	{
		String redirectUrl = "index.html?"+"change_status=failed"; // ���� ����

		//session.setAttribute("phase4_login_status", "failed");
		response.sendRedirect(redirectUrl);
	}
	
	//ResultSetMetaData rsmd = rs.getMetaData();
	//int cnt = rsmd.getColumnCount();
	//System.out.println(cnt);
	String result="none";
	
	/*
	while(rs.next()){
		result = rs.getString(1);
	}
	*/
	/*
	if (!result.equals("none"))
	{
		String redirectUrl = "index.html?"+"login_status=success&login_id="+request.getParameter("id")+"&authorization="+result; // ���� ����

		//out.print("localStorage.setItem('name', 'zerocho');");
		//session.setAttribute("phase4_login_status", "success");
		//session.setAttribute("phase4_login_id", request.getParameter("id"));
		response.sendRedirect(redirectUrl);
	}
	else
	{
		String redirectUrl = "index.html?"+"login_status=failed"; // ���� ����

		//session.setAttribute("phase4_login_status", "failed");
		response.sendRedirect(redirectUrl);
	}
	*/
	
%>
