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
	String vid = request.getParameter("vid");//�������̵�
	String price = request.getParameter("price");//����
	String mileage = request.getParameter("mileage");//����Ÿ�
	String year = request.getParameter("year");//����
	String category = request.getParameter("category");//ī�װ�
	String transmission = request.getParameter("transmission");//���
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