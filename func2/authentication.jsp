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
	
	String query = "SELECT Authorization "+
			"FROM ACCOUNT "+
			"WHERE Account_ID='"+request.getParameter("id")+"' AND Password='"+request.getParameter("pw")+"'";

	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	ResultSetMetaData rsmd = rs.getMetaData();
	//int cnt = rsmd.getColumnCount();
	//System.out.println(cnt);
	String result="none";
	
	while(rs.next()){
		result = rs.getString(1);
	}
	
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
	
%>

