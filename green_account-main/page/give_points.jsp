<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style media="screen" type="text/css">
        @import url(../asset/css/metaforms.css);
    </style>

    <title>test</title>
  </head>
  <body>
    <form action="give_points.jsp" id="first_form">
        <div class="searching">
            <div style="margin-top: 3px; margin-left: 3px;">
                <input type="text" placeholder="account_name" name = "acc">
                <input id="date_search01" type="date" name="date">
                <button id="search_btn" onclick="">search</button>
                <br><br>
                <div>
                    <table>
                        <tr>
                            <td>交易編號</td>
                            <td>會員編號</td>
                            <td>日期</td>
                            <td>店家類別</td>
                            <td>品名</td>
                            <td>類別細項</td>
                            <td>消費型態</td>
                            <td>金額</td>
                            <td>單位</td>
                            <td>碳足跡</td>     
                        </tr>
<%
    if(session.getAttribute("man_account") == null || session.getAttribute("man_account").equals("")) {
        response.sendRedirect("index.jsp");
    }
    else{
        String acc = request.getParameter("acc");        //日期篩選
        String date = request.getParameter("date");      //日期篩選
        if( date !=null  && !date.equals("")&&acc !=null  && !acc.equals("")){
            SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
            java.util.Date d = sdf.parse(date); 

            sql= "SELECT * FROM `trade` WHERE `tAccount`=? AND `tDate`=?";
            PreparedStatement ps= con.prepareStatement(sql);
            ps.setString(1, acc);
            ps.setString(2, date);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                out.println("<tr><td>"+rs.getInt("tID")+"</td>");
                out.println("<td>"+rs.getString("tAccount")+"</td>");
                out.println("<td>"+rs.getString("tDate")+"</td>");
                out.println("<td>"+rs.getString("tShop")+"</td>");
                out.println("<td>"+rs.getString("tGoods")+"</td>");
                out.println("<td>"+rs.getString("tDetail")+"</td>");
                out.println("<td class='sp'>"+rs.getString("tShape")+"</td>");
                out.println("<td>"+rs.getString("tMoney")+"</td>");
                out.println("<td>"+rs.getInt("tUnit")+"</td>");
                out.println("<td>"+rs.getInt("tCO2")+"</td>");
                out.println("</tr>");

            }
        }
    }
%>

                    </table>
                </div>
            </div>
        </div>
      </form>
      <br><br>
      
      <form action="adduserpoint.jsp" id="second_form">
        <div class="giving">
            <div style="margin-top: 3px; margin-left: 3px;">
                <span>日期：</span><input id="date_select" type="date" name="date">
                <br>

                <label for="cars">原因：</label>
                <select name="cars" id="cars">
                <option value="1">綠色商店消費</option>
                <option value="3">大型環保活動參與</option>
                <option value="4">自單位實體活動</option>
                <option value="5">使用環保餐具</option>
                <option value="6">購買綠色標章產品</option>
                </select>
                
                <div>points is for 
                    <input type="text" placeholder="account_name" name="acc">
                </div>

                <button type="submit">確定</button>
            </div>
        </div>
      </form>
  </body>
</html>
