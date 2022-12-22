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
    String acc = session.getAttribute("mem_account").toString();   
    int d =0;
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

            //把碳排加回去 還要扣點
            int tid =Integer.parseInt(delete[i]); //交易id

            //1.抓使用者碳排
            sql= "SELECT ``,`vPoint` FROM `vip` WHERE `vAccount`=?"; // 放可用碳排欄位
            ps.setString(1,acc);
            ps= con.prepareStatement(sql);
            rs = ps.executeQuery();
            rs.next();
            int havecarbon = rs.setInt(1);
            int havepoint = rs.setInt(2);
            havepoint--; //扣使用者點數
            //2.抓此紀錄碳排 
            sql= "SELECT `tCO2` FROM `trade` WHERE `tID`=?"; 
            ps.setInt(1,tid);
            ps= con.prepareStatement(sql);
            rs = ps.executeQuery();
            rs.next();
            havecarbon += rs.setInt(1); //加使用者碳排

            //3. 更新使用者資訊
            sql = "UPDATE `vip` SET ``=?,`vPoint`=? WHERE `vAccount` = ?"; // 本日碳排
            ps= con.prepareStatement(sql) ;
            ps.setInt(1, havecarbon);
            ps.setInt(2, havepoint);
            ps.setString(3, acc);
            int change = ps.executeUpdate();

            
            //4.新增點數交易紀錄
            String sqln = "INSERT INTO `tgoods` VALUES ( ? , '0' , '"+ credate +"')";
            PreparedStatement psincart = con.prepareStatement(sqln);
            psincart.setString(1,acc);
            c = psincart.executeUpdate();

            sql = "DELETE FROM `trade` WHERE`tAccount`=? AND `tID`=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, acc);
            ps.setInt(2, tid);
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