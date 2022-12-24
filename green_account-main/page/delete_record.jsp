<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "catchDateRan.jsp" %> 
<%

if(session.getAttribute("mem_account")!=null||!session.getAttribute("mem_account").equals("")){
    String delete[]= request.getParameterValues("delete");
    String acc = session.getAttribute("mem_account").toString();   
    int d =0;
    int change =0;
    int c=0;
    SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
    java.util.Date date = new java.util.Date();
    java.sql.Date now1 = new java.sql.Date(date.getTime()); 
    String cur =sdf.format(now1);
    if (delete == null || delete.length == 0) { 
        %>
            <script type="text/javascript">
                alert("請選取要刪除的項目");
                history.back();
            </script>                 
        <%            
    }
    else{
        String day="";
        int tid=0;
        for(int i = 0; i < delete.length ; i++){     

            //把碳排加回去 還要扣點
            tid =Integer.parseInt(delete[i]); //交易id

            //1.抓使用者碳排
            sql= "SELECT `vCO2`,`vPoint` FROM `vip` WHERE `vAccount`=?"; // 放可用碳排欄位
            PreparedStatement ps= con.prepareStatement(sql);
            ps.setString(1,acc);
            ResultSet rs = ps.executeQuery();
            rs.next();
            int havecarbon = rs.getInt(1);
            int havepoint = rs.getInt(2);

            if(havepoint<=0){
                %>
                    <script type="text/javascript">
                        alert("點數不足，無法刪除"+tid);
                        history.back();
                    </script>                 
                <%
            }
            else{
                    
                havepoint--; //扣使用者點數

                //2.抓此紀錄碳排 
                sql= "SELECT `tDate`,`tCO2` FROM `trade` WHERE `tID`=?"; 
                ps= con.prepareStatement(sql);  
                ps.setInt(1,tid);
                rs = ps.executeQuery();
                rs.next();
                day = rs.getString("tDate");

                //3. 更新使用者資訊
                if(day.equals(cur)){
                    havecarbon += rs.getInt("tCO2"); //加使用者可使用碳排
                }

                sql = "UPDATE `vip` SET `vCO2`=?,`vPoint`=? WHERE `vAccount` = ?"; // 本日碳排
                ps= con.prepareStatement(sql) ;
                ps.setInt(1, havecarbon);
                ps.setInt(2, havepoint);
                ps.setString(3, acc);
                change = ps.executeUpdate();

                ctime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                credate = ctime.format(new java.util.Date());


                //4.新增點數交易紀錄

                sql= "SELECT COUNT(*) FROM `tgoods` WHERE (`tgAccount`=?)";
                ps= con.prepareStatement(sql);
                ps.setString(1, acc);
                int count_id =0;
                rs = ps.executeQuery();
                rs.next();

                if(rs.getInt(1)>0){
                    sql= "SELECT `tgoodsid` FROM `tgoods` order by `tgoodsid` desc";
                    ps= con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    rs.next();
                    count_id=rs.getInt(1);
                }
                else{
                    count_id=rs.getInt(1);
                }
                    count_id++;

                String sqln = "INSERT INTO `tgoods` VALUES (?, ? , '0' , '"+credate+"')";
                PreparedStatement psincart = con.prepareStatement(sqln);
                psincart.setInt(1,count_id);
                psincart.setString(2,acc);
                c = psincart.executeUpdate();



                sql = "DELETE FROM `trade` WHERE `tID`=? AND `tAccount`=?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, tid);
                ps.setString(2, acc);
                d = ps.executeUpdate();

                if(!(d>0)){
                    %>
                        <script type="text/javascript">
                            alert("刪除失敗");
                            history.back();
                        </script>                 
                    <%
                }
                if(!(c>0)){
                    %>
                        <script type="text/javascript">
                            alert("新增交易失敗");
                            history.back();
                        </script>                 
                    <%
                }
                if(!(change>0)){
                    %>
                        <script type="text/javascript">
                            alert("更新資訊失敗");
                            history.back();
                        </script>                 
                    <%
                }
            }
           
        }

        



        if(d>0&&change>0&&c>0){
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
else{
    response.sendRedirect("index.jsp");
}
%>