<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 
<%

if(session.getAttribute("mem_account")!=null||!session.getAttribute("mem_account").equals("")){
    String delete[]= request.getParameterValues("delete");

    if (delete == null || delete.length == 0) { 
        %>
            <script type="text/javascript">
                alert("請選取要刪除的項目");
                history.back();
            </script>                 
        <%            
    }
    else{
        for(int i = 0; i < delete.length; i++){     

            //要把碳排加回去


            sql = "DELETE FROM `trade` WHERE `tID`=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(delete[i]));
            int d = ps.executeUpdate();

            if(d>0){
                response.sendRedirect("account.jsp");
            }
            else{
                %>
                    <script type="text/javascript">
                        alert("刪除失敗");
                        history.back();
                    </script>                 
                <%
            }    
        }

    }
}
else{
    response.sendRedirect("index.jsp");
}
%>