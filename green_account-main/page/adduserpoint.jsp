<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 
<%
    String date=request.getParameter("date"); 
    Integer reason = Integer.parseInt(request.getParameter("cars")); 
    String acc = request.getParameter("acc");  

    if(session.getAttribute("man_account") == null || session.getAttribute("man_account").equals("")) {
        response.sendRedirect("index.jsp");
    }
    else{
        if(date !=null  && !date.equals("")&&acc !=null  && !acc.equals("")
           &&reason !=null  && !reason.equals("")){
            SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
            java.util.Date d = sdf.parse(date); 

            java.util.Date dat = new java.util.Date();
            java.sql.Date now = new java.sql.Date(dat.getTime()); 
            String cur =sdf.format(now);
            
            sql= "SELECT `aPoint` FROM `activity` WHERE `aID`=?"; 
            PreparedStatement ps= con.prepareStatement(sql);
            ps.setInt(1,reason);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int point = rs.getInt(1);

            sql= "SELECT `vPoint` FROM `vip` WHERE `vAccount`=?"; 
            ps= con.prepareStatement(sql);
            ps.setString(1,acc);
            rs = ps.executeQuery();
            int change=0;
            int y1=0;
            if(rs.next()){
                int user_point = rs.getInt(1);

                
                sql= "SELECT COUNT(*) FROM `vactivity`";
                ps= con.prepareStatement(sql);
                int count_id =0;
                rs = ps.executeQuery();
                rs.next();

                if(rs.getInt(1)>0){
                    sql= "SELECT `ID` FROM `vactivity` order by `id` desc";
                    ps= con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    rs.next();
                    count_id=rs.getInt(1);
                }
                else{
                    count_id=rs.getInt(1);
                }
                    count_id++;

                sql = "INSERT INTO `vactivity` VALUES ( '"+count_id +"','"+ acc + "','"+ reason + "', '"+ date + "')";
                y1 = con.createStatement().executeUpdate(sql);
                user_point+=point;
                
                sql = "UPDATE `vip` SET `vPoint`=? WHERE `vAccount` = ?"; // 本日碳排
                ps= con.prepareStatement(sql) ;
                ps.setInt(1, user_point);
                ps.setString(2, acc);
                change = ps.executeUpdate();
                if(y1 >0&&change>0){
                    response.sendRedirect("give_points.jsp");
                }
                else{
                    %>
                        <script type="text/javascript">
                            alert("起始日期請勿超過終止日期");
                        </script>                 
                    <%
                }

            }
            else{
                %>
                    <script type="text/javascript">
                        alert("沒有這個使用者");
                    </script>                 
                <%
            }






        }
        else{
            %>
                <script type="text/javascript">
                    alert("請填寫完整資訊");
                    history.back();
                </script>                 
            <%
        }


    }
%>