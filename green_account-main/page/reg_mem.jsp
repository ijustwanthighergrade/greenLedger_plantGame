<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 

<%
    String racc = request.getParameter("racc"); 
    String rpwd = request.getParameter("rpwd");
    String rname = request.getParameter("rname");
    String rmail = request.getParameter("rmail");
    String rbirth = request.getParameter("rbirth");
    String sexual = request.getParameter("sexual");
    String radd = request.getParameter("radd");
    String rphone = request.getParameter("rphone");


    if( racc !=null && !racc.equals("") && rpwd != null && !rpwd.equals("")){
        
        SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd" ); 
        java.util.Date d = sdf.parse(rbirth); 
        java.sql.Date d1 = new java.sql.Date(d.getTime()); 
        java.util.Date date = new java.util.Date();
        java.sql.Date now1 = new java.sql.Date(date.getTime()); 
        boolean a =d1.before(now1);
        
        if(!a){
            %>
                <script type="text/javascript">
                    alert("生日請勿超過今日日期");
                    history.back();
                </script>                 
            <%
        }

        sql= "SELECT `vAccount` FROM `vip` WHERE `vAccount`=?";
        PreparedStatement ps= con.prepareStatement(sql);
        ps.setString(1, racc);
        ResultSet rsp = ps.executeQuery();
        
        int y=0,y1=0;
        if( !rsp.next() ){
            sql = "INSERT INTO `vip` VALUES ( '"+ racc + "','"+ rpwd + "', '"+ rname + "', '"+ sexual + "', '"+ rbirth + "', '"+ rmail + "', '"+ rphone + "', '"+ radd + "','"+y1+"','20')";
         
            y1 = con.createStatement().executeUpdate(sql);
        }
        else{ %>
            <script src="../asset/js/rfail.js"></script>
            <%  //response.sendRedirect("login.jsp");
        } 
        out.println(y1);
        int k=0;
        if ( y1>0 ){%>
            <%
            if(k==0){
            %>
                
            <%      k=1;
            } 
            if(k==1){
                con.close();
                response.sendRedirect("login_mem.jsp?lacc="+racc+"&lpwd="+rpwd);  
            }  
        }
    }
    else{
        %>
            <script type="text/javascript">
                alert("填寫項不可為空");
                history.back();
            </script>                 
        <%
    }
%>
   