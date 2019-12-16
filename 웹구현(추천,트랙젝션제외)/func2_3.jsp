<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@page import="java.util.*" %>
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
   <h2 align="center">A List of Vehicle</h2>   
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
   
   ArrayList<String> items = new ArrayList<>();
   String vid = request.getParameter("vid");//차량아이디
   String price = request.getParameter("price");//가격
   String mileage = request.getParameter("mileage");//주행거리
   String model_year = request.getParameter("year");//연식
   String cname = request.getParameter("category");//카테고리
   String tname = request.getParameter("transmission");//기어
   String ename = request.getParameter("engine_displacement");
   String mname = request.getParameter("company");
   String modelname = request.getParameter("model");
   String dname = request.getParameter("detailed_model");
   String fuel = request.getParameter("fuel");
   String cn = request.getParameter("color");
   
   if(!vid.equals("")){
         items.add(vid);
      }
      if(!price.equals("")){
         items.add(price);
      }
      if(!mileage.equals("")){
         items.add(mileage);
      }
      if(!model_year.equals("")){
         items.add(model_year);
      }
      if(!cname.equals("")){
         items.add(cname);
      }
      if(!tname.equals("")){
         items.add(tname);
      }
      if(!ename.equals("")){
         items.add(ename);
      }
      if(!mname.equals("")){
         items.add(mname);
      }
      if(!modelname.equals("")){
         items.add(modelname);
      }
      if(!dname.equals("")){
         items.add(dname);
      }
      if(!fuel.equals("")){
         items.add(fuel);
      }
      if(!cn.equals("")){
         items.add(cn);
      }
      System.out.println("size:"+ items.size());

      int k = 0;
      
      int flag = 0;
      int two = 0;
      String temp = "(select *\r\n" + 
            "from vehicle \r\n" + 
            "natural join\r\n" + 
            "(select vehicle_id from vehicle minus\r\n" + 
            "select distinct vehicle_id from vehicle,order_ where vehicle_id = order_vid order by vehicle_id asc))";
      String sql = "select vehicle_id ";
      String from = "from "+temp+" v ";
      String where = " where is_opened=1 and  ";
      String group = null;
      String order = null;
      String having = null;
      String from2="",where2="";
      int sum = 1;
      
      if(!vid.equals("")) {
//        if(flag == 1)
//           sql+="and ";
        flag = 1;
        if(sum == items.size()) {
           where += ("v.vehicle_id = "+vid);
        }else {
           where += ("v.vehicle_id = "+vid+" and ");
        }
        sum++;
     }
      
      if(!price.equals("")) {
//        if(flag == 1)
//           sql+="and ";
        flag = 1;
        if(sum == items.size()) {
           where += ("v.price = "+price);
        }else {
           where += ("v.price = "+price+" and ");
        }
        sum++;
     }

      if(!mileage.equals("")) {
          if(sum == items.size()) {
             where += ("v.mileage = "+mileage);
          }else {
             where += ("v.mileage = "+mileage + " and ");
          }
          sum++;
          
     }
     
      if(!model_year.equals("")) {
          if(sum == items.size()) {
             where += ("model_year  = "+ "'"+model_year+"'");
          }else {
             where += ("model_year  = "+ "'"+model_year+"' and ");
          }
          sum++;
       }
      
      if(!cname.equals("")) {
          if(sum == items.size()) {
             from += ",CATEGORY c";
             where += ("v.vehicle_cid = c.category_id and c.category_name = "+"'"+cname+"'");
          }else {
             from += ",CATEGORY c";
             where += ("v.vehicle_cid = c.category_id and c.category_name = "+"'"+cname+"' and ");
          }
          sum++;
       }
   
      if(!tname.equals("")) {
          if(sum == items.size()) {
             from += ",TRANSMISSION t";
             where += ("v.vehicle_tid = t.transmission_id and t.transmission_name = "+"'"+tname+"'");
          }else {
             from += ",TRANSMISSION t";
             where += ("v.vehicle_tid = t.transmission_id and t.transmission_name = "+"'"+tname+"' and ");
          }
          sum++;
      }
      
      if(!ename.equals("")) {
          if(sum == items.size()) {
             from +=",ENGINE_DISPLACEMENT e";
             where +=("v.vehicle_eid = e.engine_displacement_id and e.engine_displacement_name = "+ename);
          }else {
             from +=",ENGINE_DISPLACEMENT e";
             where +=("v.vehicle_eid = e.engine_displacement_id and e.engine_displacement_name = "+ename +" and");
          }
          sum++;
      }
      
      if(!mname.equals("")) {
          if(sum == items.size()) {
             from +=",Make m";
             where += " v.vehicle_makeid = m.make_id and m.make_name = "+"'"+mname+"'";
          }else {
             from +=",Make m ";
             where += " v.vehicle_makeid = m.make_id and m.make_name = "+"'"+mname+"' and ";
          }
          sum++;
      }

      if(!modelname.equals("")) {
          if(sum == items.size()) {
             from += ",MODEL mo";
             where += "v.vehicle_modelid = mo.model_name and mo.model_name = "+"'"+modelname+"'";
          }else {
             from += ",MODEL mo";
             where += "v.vehicle_modelid = mo.model_name and mo.model_name = "+"'"+modelname+"' and ";
          }
          sum++;
       }
      
      if(!dname.equals("")) {
          if(sum == items.size()) {
             from += ",DETAILED_MODEL d";
             where += "v.vehicle_did = d.detailed_model_name and d.detailed_model_name = "+"'"+dname+"'";
          }else {
             from += ",DETAILED_MODEL d";
             where += "v.vehicle_did = d.detailed_model_name and d.detailed_model_name = "+"'"+dname+"' and ";
          }
          sum++;
       }
      
      if(!fuel.equals("")) { // 연료
          from2 = from;
          where2 = where;
          System.out.println("연로를 입력하세요.(or,and)");
          where += "(vf.vehicle_fuel_fid = f.fuel_id) and (v.vehicle_id = vf.vehicle_fuel_vid) and (";
          if(fuel.contains("or")){
             String[] flist = fuel.split(" or ");
             
             for(int i =0;i<flist.length;i++) {
                if(flist.length - 1 == i)
                   where += "f.fuel_name = "+"'"+flist[i]+"') ";  //마지막 or는 빼야함
                else
                   where += "f.fuel_name = "+"'"+flist[i]+"' or ";
             }
          }else if(fuel.contains("and")){
             String[] flist = fuel.split(" and ");
             for(int i =0;i<flist.length;i++) {
                if(flist.length - 1 == i)
                   where += "f.fuel_name = "+"'"+flist[i]+"') ";
                else
                   where += "f.fuel_name = "+"'"+flist[i]+"' or ";
             }
             having = " having count(*) = "+flist.length;
          }
          
          else {
             where +="f.fuel_name =  "+"'"+fuel+"') ";
          }
          
          from += ",VEHICLE_FUEL vf, FUEL f ";
          
     }
      
      if( (!fuel.equals("")) && (!cn.equals(""))) {
          String sql2;
          order = " order by vehicle_id asc";
          group = " group by vehicle_id";
          sql2 = sql+from+where;
          sql2+=group;
          if(having!=null)
             sql2+=having;
          sql2+=order;
          System.out.println("sql2 : "+sql2); //여기까지 연료관련 sql
          
          having = null;
          
          String sql3="";
          where2 += "(vehicle_id = vehicle_color_vid) and (vehicle_color_cid = color_id) and ";
          if(cn.contains("or")) {
             String clist[] = cn.split(" or ");
             where2 += "(vehicle_id = vehicle_color_vid) and (vehicle_color_cid = color_id) and (";
             for(int i =0;i<clist.length;i++) {
                if(i == clist.length-1) {
                   where2 += "color_name = "+"'"+clist[i]+"')";
                }else {
                   where2 += "color_name = "+"'"+clist[i]+"' or ";
                }
                
             }   
          }else if(cn.contains("and")) {
             String clist[] = cn.split(" and ");
             where2 += "(vehicle_id = vehicle_color_vid) and (vehicle_color_cid = color_id) and (";
             for(int i =0;i<clist.length;i++) {
                if(i == clist.length-1) {
                   where2 += "color_name = "+"'"+clist[i]+"')";
                }else {
                   where2 += "color_name = "+"'"+clist[i]+"' or ";
                }
             }
             having = " having count(*) = "+ clist.length;
          }else {
             where2 += "color_name = "+ "'"+cn+"'";
          }
          
          from2 += ",vehicle_color ,color";
          sql3 = sql+from2+where2;
          sql3+=group;
          if(having!=null)
             sql3+=having;
          
          sql3+=order;
          System.out.println("sql3 : "+sql3);
          sql = sql + "from ("+sql2+") natural join "+"("+sql3+")";
          System.out.println("sql : "+ sql);
          
          pstmt = conn.prepareStatement(sql);
          rs = pstmt.executeQuery();

          out.println("<table border = \"1\">");
          ResultSetMetaData rsmd = rs.getMetaData();
          int cnt = rsmd.getColumnCount();
          for(int i =1;i<=cnt;i++)
             out.println("<th>"+rsmd.getColumnName(i)+"</th>");
          while(rs.next()){
           k++;
            out.println("<tr>");
            out.println("<td>"+rs.getString(1)+"</td>");
            out.println("</tr>");
            }
         out.println("</table>");
          two = 1;
       }
      
      if(!cn.equals("") && two == 0) { //색상
          where += "(vehicle_id = vehicle_color_vid) and (vehicle_color_cid = color_id) and ";
          if(cn.contains("or")) {
             String clist[] = cn.split(" or ");
             where += "(vehicle_id = vehicle_color_vid) and (vehicle_color_cid = color_id) and (";
             for(int i =0;i<clist.length;i++) {
                if(i == clist.length-1) {
                   where += "color_name = "+"'"+clist[i]+"')";
                }else {
                   where += "color_name = "+"'"+clist[i]+"' or ";
                }
                
             }
             
          }else if(cn.contains("and")) {
             String clist[] = cn.split(" and ");
             where += "(vehicle_id = vehicle_color_vid) and (vehicle_color_cid = color_id) and (";
             for(int i =0;i<clist.length;i++) {
                if(i == clist.length-1) {
                   where += "color_name = "+"'"+clist[i]+"')";
                }else {
                   where += "color_name = "+"'"+clist[i]+"' or ";
                }
             }
             having = " having count(*) = "+ clist.length;
          }else {
             where += "color_name = "+ "'"+cn+"'";
             
          }
          
          from += ",vehicle_color ,color";
       }
       if(two == 0) {
          order = " order by vehicle_id asc";
          group = " group by vehicle_id";
          sql = sql+from+where;
          sql+=group;
          if(having!=null)
             sql+=having;
          
          sql+=order;
          System.out.println("sql : "+sql);
          System.out.println(sql);
          pstmt = conn.prepareStatement(sql);
          rs = pstmt.executeQuery();
          
          out.println("<table border = \"1\">");
          ResultSetMetaData rsmd = rs.getMetaData();
          int cnt = rsmd.getColumnCount();
          for(int i =1;i<=cnt;i++)
             out.println("<th>"+rsmd.getColumnName(i)+"</th>");
          while(rs.next()){
                k++;
              out.println("<tr>");
              out.println("<td>"+rs.getString(1)+"</td>");
              out.println("</tr>");
              }
           out.println("</table>");
       }
       
       if(k>0){
          String form = "<form method=\"post\" action=\"vid_search.jsp\"> 차량 아이디 입력 : <input type=\"text\" name = \"vid\"><br><input type=\"submit\" value=\"검색\"></form>" ; 
          out.println(form);
       }
%>

      
</body>
</html>