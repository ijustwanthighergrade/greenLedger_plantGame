<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 
<%
    String lacc = request.getParameter("lacc");
    String lpwd = request.getParameter("lpwd");
    ResultSet rs;
    PreparedStatement ps;

   if( lacc !=null && !lacc.equals("") && lpwd != null && !lpwd.equals("")){ 
    
        sql = "SELECT `vAccount`,`vPassword` FROM `vip` WHERE `vAccount`=? AND `vPassword`=?";

        ps = con.prepareStatement(sql);

        ps.setString(1, lacc);
        ps.setString(2, lpwd);

        rs = ps.executeQuery();

        if(rs.next()){            
            session.setAttribute("mem_account", lacc);
            con.close();
            response.sendRedirect("index.jsp") ;
        }
        else{
            con.close();
             %>
            <script type="text/javascript">
                alert("帳號密碼不符，請重新登入");
                history.back();
            </script>                 
            <%
            //out.println("帳號密碼不符<a href='login.jsp'>重新登入</a>") ;
        }
    }
    else
	    response.sendRedirect("index.jsp");

%>