<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="../asset/img/green-power.png" type="image/x-icon" />
    <title>存碳養綠</title>
    <style>
        @import url(../asset/css/main.css);
        @import url(../asset/css/nav.css);
        @import url(../asset/css/shop.css);
        @import url(../asset/css/animation.css);
    </style>
</head>
<body>
    <main>
        <aside id="main_title">
            <h1>點數商店</h1>
        </aside>
    <%
        if(session.getAttribute("mem_account") == null || session.getAttribute("mem_account").equals("")) {
           response.sendRedirect("index.jsp");
        }
        else{
            String acc = session.getAttribute("mem_account").toString();
            
            sql = "SELECT `vPoint` FROM `vip` WHERE `vAccount` ='"+ acc +"'";
            ResultSet rs1 = con.createStatement().executeQuery(sql);
            rs1.next();

            String sql1 = "SELECT * FROM `goods`";
            ResultSet rs2 = con.createStatement().executeQuery(sql1);
    %>

        <aside id="main_body">
            <div id="have">
                <p>持有點數：</p>
                <p><%out.println(rs1.getInt("vPoint"));%>點</p>
            </div>
            <section class='goods_aera'>
                <%
                    int k = 1;
                    while(rs2.next()){
                        if (k%5!=0){
                            k++;
                            out.println("<div class='goods'>");
                            out.println("<p>"+rs2.getString("gName")+"</p>");
                            out.println("<div class='goods_img'>");
                            out.println("<p>剩餘：</p><p>"+rs2.getInt("gStock")+"</p>");
                            out.println("<img src='../asset/img/"+rs2.getString("gPhoto")+"' alt=''> </div>");
                            out.println("<button type='submit' class='goods_btn' onclick='point("+rs2.getInt("gID")+");'>"+rs2.getInt("gPoint")+"點</button>");
                            out.println("</div>");
                        }
                        else{
                            out.println("</div></section>");
                            out.println("<section class='goods_aera'>");
                            out.println("<div class='goods'>");
                            out.println("<p>"+rs2.getString("gName")+"</p>");
                            out.println("<div class='goods_img'>");
                            out.println("<p>剩餘：</p><p>"+rs2.getInt("gStock")+"</p>");
                            out.println("<img src='../asset/img/"+rs2.getString("gPhoto")+"' alt=''> </div>");
                            out.println("<button type='submit' class='goods_btn' onclick='point("+rs2.getInt("gID")+");'>"+rs2.getInt("gPoint")+"點</button>");
                            out.println("</div>");
                            out.println("</div>");
                            
                            k=2;
                        }
                    }
                
                %>
            


        </aside>
          <% }%>  
        
    </main>
    <div id="to_top">
        <div id="top"></div>
        <a href="#">
            <img src="../asset/img/earth-day.png" alt="" id="top_btn">
        </a>
    </div>
    <footer></footer>
    <iframe src="../page/nav.html" id="navBar" frameborder="0" scrolling="no"></iframe>
</body>
</html>

<script>
    function point(a){
            if(confirm('確定兌換？')){location='buynow.jsp?id='+a}
            else
                location='shop.jsp'
    }
</script>