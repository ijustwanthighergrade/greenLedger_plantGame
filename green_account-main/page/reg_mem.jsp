<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@include file="connectsql.jsp" %> 

<%
    String racc = request.getParameter("racc"); 
    String rpwd = request.getParameter("rpwd");
    String rname = request.getParameter("rname");
    String rmail = request.getParameter("rmail");
    String rbirth = request.getParameter("rbirth");
    String sexual = request.getParameter("sexual");
    String radd = request.getParameter("radd");
    String rphone = request.getParameter("rphone");


    if( racc !=null && !racc.equals("") && rpwd != null && !rpwd.equals("")
    && rname !=null && !rname.equals("") && rmail != null && !rmail.equals("")
    && rbirth !=null && !rbirth.equals("") && sexual != null && !sexual.equals("")
    && radd !=null && !radd.equals("") && rphone != null && !rphone.equals("")){
        
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
            
            /* 補齊用戶在"game.jsp"會用到的SQL欄位 */
            PreparedStatement stmt;
            sql = "INSERT INTO `vflower` VALUE('"+ racc +"', 1 ,'種子', 0 , 0 )";
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            sql = "INSERT INTO `sign` VALUE('"+ racc +"', 0 , 0 , 0 , 0 , 0 , 0 , 0 )";
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            sql = "INSERT INTO `back` VALUE( 0 ,'"+ racc +"', 'fertilizer2.png' , 0 )";
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            sql = "INSERT INTO `back` VALUE( 1 ,'"+ racc +"', 'fertilizer.png' , 0 )";
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            sql = "INSERT INTO `back` VALUE( 2 ,'"+ racc +"', 'watercan.png' , 0 )";
            stmt = con.prepareStatement(sql);
            stmt.executeUpdate();
            
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
   
