<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!--  import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>

<%
	String serverIP = "155.230.36.61";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "s2015110986";
	String pass = "hsb2537";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	Statement stmt = null;	
	
	String id = request.getParameter("outid");
	String password = request.getParameter("outpassword");
	
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();
	
	String sql = "select * from account where authorization = "+"'"+"manager"+"'";
	rs = stmt.executeQuery(sql);
	
	int checknum=1;
	
	int rowCount=0;
	System.out.print(rowCount);
	while(rs.next())
		rowCount++;
	
	sql = "select authorization from account where account_id ="+"'"+id+"' and password = "+"'"+password+"'";
	rs = stmt.executeQuery(sql);
	
	while(rs.next()) {
		if(rs.getString(1).equals("manager")&&rowCount==1) {
			checknum=0;
			String redirectUrl = "index.html?"+"out_status=refused"; //
			response.sendRedirect(redirectUrl);
		}
	}
	
	if(checknum==1)
	{
		String query ="delete from account where account_id = "+"'"+id+"'"+ " and password= " + "'"+password+ "'";
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		try{
			rs = pstmt.executeQuery();
			String redirectUrl = "index.html?"+"out_status=success"; //
			response.sendRedirect(redirectUrl);
		}catch(Exception e)
		{
			e.printStackTrace();
			String redirectUrl = "index.html?"+"out_status=failed"; // 인증 실패
	
			//session.setAttribute("phase4_login_status", "failed");
			response.sendRedirect(redirectUrl);
		}
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
		String redirectUrl = "index.html?"+"login_status=success&login_id="+request.getParameter("id")+"&authorization="+result; // 인증 성공

		//out.print("localStorage.setItem('name', 'zerocho');");
		//session.setAttribute("phase4_login_status", "success");
		//session.setAttribute("phase4_login_id", request.getParameter("id"));
		response.sendRedirect(redirectUrl);
	}
	else
	{
		String redirectUrl = "index.html?"+"login_status=failed"; // 인증 실패

		//session.setAttribute("phase4_login_status", "failed");
		response.sendRedirect(redirectUrl);
	}
	*/
	
%>

