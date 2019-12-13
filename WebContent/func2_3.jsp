<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
     <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String vid = request.getParameter("vid");//차량아이디
	String price = request.getParameter("price");//가격
	String mileage = request.getParameter("mileage");//주행거리
	String year = request.getParameter("year");//연식
	String category = request.getParameter("category");//카테고리
	String transmission = request.getParameter("transmission");//기어
	String engine_displacement = request.getParameter("engine_displacement");
	String company = request.getParameter("company");
	String model = request.getParameter("model");
	String detailed_model = request.getParameter("detailed_model");
	String fuel = request.getParameter("fuel");
	String color = request.getParameter("color");
	out.println("vid : "+vid);
	out.println("price : "+price);
	out.println("mileage : "+mileage);
	out.println("year : "+year);
	out.println("category : "+ category);
%>
</body>
</html>