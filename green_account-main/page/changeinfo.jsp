<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@include file="connectsql.jsp" %> 
<%
    String name = request.getParameter("mname");
    String email = request.getParameter("memail");
    String phone = request.getParameter("mphone");
    String sexual = request.getParameter("sexual");
    String pwd = request.getParameter("pwd");
    String addr= request.getParameter("addr");
    int lang=phone.length();
    //
    if( !phone.substring(0,2).equals("09") || lang != 10 || name.length() > 16 || name.equals("") || name==null ||
    email.length() > 128  ){%>
        <script src="../asset/js/changefail.js"></script>
    <%}
    else{
        if( session.getAttribute("mem_account") != null && !session.getAttribute("mem_account").equals("") ) {
            
            String acc = session.getAttribute("mem_account").toString();
            PreparedStatement ps;
        
            sql = "UPDATE `vip` SET `vPassword` = ?, `vName`=?, `vGender`=?,`vMail`=?,`vPhone`=?,`vAddress`=? WHERE `vAccount` ='"+acc+"'";

            ps= con.prepareStatement(sql) ;
            ps.setString(1, pwd);
            ps.setString(2, name);
            ps.setString(3, sexual);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, addr);
                
               
            int change = ps.executeUpdate();
            //int change = con.createStatement().executeUpdate(sql);
            if(change>0){
                con.close();%>
                <script>
                    alert("更新成功");
                </script>
                <%
                    response.sendRedirect("user.jsp");
            }
            else{
                %>
                <script>
                    alert("更新失敗");
                </script>
                <%
                    response.sendRedirect("user.jsp");
            }
        }
        else{
            response.sendRedirect("index.jsp");
        }
    }

%>
