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
	
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();
	
	String query ="insert into account  values(" + "'"+request.getParameter("id")+"'," + "'"+request.getParameter("password")+"',"+"'"+request.getParameter("name")+"',"
			+"'"+request.getParameter("sex")+"',"+ "to_date("+"'"+request.getParameter("birthdate")+"',"+"'yyyy-mm-dd'),"+"'"+request.getParameter("phonenumber")+"',"+"'"+request.getParameter("address")+"',"+"'"+request.getParameter("profession")+"',"+"'"+"normal"+"')";
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	try{
		rs = pstmt.executeQuery();
		String redirectUrl = "index.html?"+"register_status=success"; //
		response.sendRedirect(redirectUrl);
	}catch(Exception e)
	{
		String redirectUrl = "index.html?"+"register_status=failed"; // 인증 실패

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

