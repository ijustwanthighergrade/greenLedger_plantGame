<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 
<%

if(session.getAttribute("mem_account") == null || session.getAttribute("mem_account").equals("")) {
    response.sendRedirect("index.jsp");
}    
else{
    String acc = session.getAttribute("mem_account").toString();   
    String gacc = request.getParameter("id");
    int treceive_co=0;
    int i_co=0;
    int change=0;
    int change1=0;
    int show = 0;

    // 抓自己的vCO2
    sql= "SELECT `vCO2` FROM `vip` WHERE `vAccount`=?";
    PreparedStatement ps= con.prepareStatement(sql);
    ps.setString(1, acc);
    ResultSet rs = ps.executeQuery();
    rs.next();
    i_co = rs.getInt("vCO2");

    sql= "SELECT `vCO2` FROM `vip` WHERE `vAccount`=?";
    ps= con.prepareStatement(sql);
    ps.setString(1, gacc);
    rs = ps.executeQuery();
    
    if(rs.next()){
        treceive_co = rs.getInt("vCO2"); //抓要給的人的vCO2
        treceive_co+=i_co;

        //更新給的那個人的資料
        sql = "UPDATE `vip` SET `vCO2`=? WHERE `vAccount` = ?"; // 本日碳排
        ps= con.prepareStatement(sql) ;
        ps.setInt(1, treceive_co);
        ps.setString(2, gacc);
        change = ps.executeUpdate();
        //把自己的碳排變成0
        sql = "UPDATE `vip` SET `vCO2`=? WHERE `vAccount` = ?"; // 本日碳排
        ps= con.prepareStatement(sql) ;
        ps.setInt(1, 0);
        ps.setString(2, acc);
        change1 = ps.executeUpdate();

        
            if(change>0&&change1>0){
            %>
            <script type="text/javascript">
                alert("成功送達");
                history.back();
            </script>                 
            <%
                response.sendRedirect("account.jsp");
            }
            else{
                %>
                <script type="text/javascript">
                    alert("更新失敗");
                    history.back();
                </script>                 
                <%
            }

        
    }
    else{
        %>
            <script type="text/javascript">
                alert("查無此帳號");
                history.back();
            </script>                 
        <%
    }

}

%>