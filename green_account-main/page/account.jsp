<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="connectsql.jsp" %> 

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
        @import url(../../account.css);
        @import url(../asset/css/animation.css);
    </style>
</head>
<body>
<%
    if(session.getAttribute("mem_account") == null || session.getAttribute("mem_account").equals("")) {
        response.sendRedirect("index.jsp");
    }
    else{
        String acc = session.getAttribute("mem_account").toString();
        String date1 = request.getParameter("d1"); //日期篩選
        String date2 = request.getParameter("d2"); //日期篩選

        //下拉式清單
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
        java.util.Date date = new java.util.Date();
        java.sql.Date now1 = new java.sql.Date(date.getTime()); 
        String cur =sdf.format(now1);

        

        if( date1 !=null  && !date1.equals("")&&date2 !=null  && !date2.equals("")){
            
            java.util.Date da1 = sdf.parse(date1); 
            java.util.Date da2 = sdf.parse(date2); 
            boolean b = da1.before(now1);
            boolean c = da2.before(now1);
            boolean a = da1.before(da2); //第一個不可以比第二個後面
            boolean d = da1.equals(da2);
            boolean e = da2.equals(da1);

            if(e||d){
                da1=da2;
            }
            else if(!a){
                %>
                    <script type="text/javascript">
                        alert("起始日期請勿超過終止日期");
                        history.back();
                    </script>                 
                <%
            }

            if(!b||!c){
                %>
                    <script type="text/javascript">
                        alert("請勿超過今日日期");
                        history.back();
                    </script>                 
                <%
            }
        }
        else{
            date1="";
           date2="";
        }

%>
    <main>
        <aside id="main_title">
            <h1>綠色記帳本</h1>
        </aside>
        <aside id="main_body">
            <div id="add">
            <%
                        
                ResultSet rs;
                sql= "SELECT `vCO2` FROM `vip` WHERE `vAccount`=?"; // 放可用碳排欄位
                PreparedStatement ps= con.prepareStatement(sql);
                ps.setString(1,acc);
                rs = ps.executeQuery();
                rs.next();
                int haveco = rs.getInt(1);

                if(haveco<=0){
                    out.println("<form name='myForm' action='addrecord.jsp' onSubmit='return addFunction();'>");
                }
                else{
                    out.println("<form name='myForm' action='addrecord.jsp'>");
                }
            %>
                    <h2>日期 ：<input type="date" name="add_date" id="add_date"></h2><br>
                    <select name="type" id="add_type" onChange="renew(this.selectedIndex);">
                        <option value="" disabled selected hidden>類別</option>
                        <option value="食">食</option>
                        <option value="衣">衣</option>
                        <option value="住">住</option>
                        <option value="行">行</option>
                        <option value="其他">其他</option>
                    </select>
                    <select name="typeDetail" id="add_type_detail">
                        <option value="" disabled selected hidden>細項</option>
                    </select>
                    <input type="number" name="money" id="add_money" placeholder="$ 金額" min="0">
                    <select name="store" id="add_shop">
                        <option value="" disabled selected hidden>店家</option>
                        <option value="獨立商店">獨立商店</option>
                        <option value="連鎖商店">連鎖商店</option>
                        <option value="便利商店負碳商品專區">便利商店_負碳商品專區</option>
                        <option value="便利商店一般">便利商店_一般</option>
                        <option value="綠色商店">綠色商店</option>
                        <option value="其他">其他</option>
                    </select>
                    <script>
                        department=new Array();
                        department[0]=[];	
                        department[1]=["素食", "非素食"];	
                        department[2]=["衣"];
                        department[3]=["月水電費","月瓦斯費"];
                        department[4]=["自駕油費", "捷運", "公車", "鐵路", "長程飛機", "短程飛機"];
                        department[5]=["具有綠色標章", "非綠色標章"];

                        function renew(index){
                            for(var i=0;i<department[index].length;i++)
                                document.myForm.typeDetail.options[i]=new Option(department[index][i], department[index][i]);	// 設定新選項
                                document.myForm.typeDetail.length=department[index].length;	// 刪除多餘的選項
                        }
                    </script>
                    <input type="number" name="unit" id="add_unit" placeholder="單位" min="0" title="火車公里/公車、捷運站數/份數/飛機次數/加油公升數">
                    <input type='submit' value='新增' id='add_btn'>
                    
                    <br>
                    <script>
                        function addFunction()
                        {
                            if(confirm('此紀錄碳足跡量已超標!! \n 未來您的孫子沒有家了哭哭 °(°ˊДˋ°) °'))this.form.submit();
                        }
                    </script>
                    <select name="way" id="add_buy">
                        <option value="自購">自行到店</option>
                        <option value="網路">網購</option>
                    </select>
                    <input type="text" name="pname" placeholder="品名" id="productName">
                </form>
            </div>
<%

        sql= "SELECT SUM(`tMoney`) FROM `trade` WHERE `tAccount`=? AND `tDate`=?";
        PreparedStatement ps1= con.prepareStatement(sql);
        ps1.setString(1, acc);
        ps1.setString(2, cur);
        ResultSet rs1 = ps1.executeQuery();
        rs1.next();
        int todaymoney = rs1.getInt(1);
        sql= "SELECT SUM(`tCO2`) FROM `trade` WHERE `tAccount`=? AND `tDate`=?";
        ps1= con.prepareStatement(sql);
        ps1.setString(1, acc);
        ps1.setString(2, cur);
        rs1 = ps1.executeQuery();
        rs1.next();
        int todaycarbon = rs1.getInt(1);

        String standerd = "";
        if(todaycarbon<7&&todaycarbon>=0){
            standerd="低";
        }
        else if(todaycarbon>=7&&todaycarbon<20){
            standerd="理想";
        }
        else if(todaycarbon>=20&&todaycarbon<27){
            standerd="普通";
        }
        else{
            standerd="高";
        }



%>
            <div id="today">
                <p>本日消費金額：</p>
                    <p><%out.println(todaymoney);%></p>
                    <p>元 碳排量：</p>
                    <p><%out.println(todaycarbon);%></p>
                    <p>kg 碳排量指標 </p>
                    <p><%out.println(standerd);%></p>
                    <%
                        if(haveco>0){
                            out.println("<button type='submit' onclick='show()'>");
                            out.println("已省下碳排量 <br>");
                            out.println(haveco+"kg");
                            out.println("</button>");
                        }
                        else{
                            out.println("<button type='submit'>");
                            out.println("碳排量已超過理想值<br>");
                            out.println(-haveco+"kg");
                            out.println("</button>");
                        }
                    %>
                <script>
                    function show(){
                        var give_acc = window.prompt("輸入贈與人會員帳號");
                        if(give_acc!=""){
                            location='giveco2.jsp?gacc='+give_acc;
                        }
                        else{
                            location='account.jsp'
                        }
                    }
                </script>
            </div>
            <div class="data">
                <section id="data_detail">
                    <div id="date_Range">
                        <form action="account.jsp">
                            <input type="date" name="d1" class="Range_1">
                            <p>~</p>
                            <input type="date" name="d2" class="Range_2">
                            <button type="submit" id="Range_btn">GO</button>
                        </form>
                    </div>
                </section>
                <section id="data_chart">
                    <div id="chart_title">
                        <p>顯示圖表</p>
                    </div>
                    <div id="data_chart_show">
                        
                    </div>
                </section>
                <section id="data_record">
                
                    <div id="record_title">
                        <p id="record_data1"><%out.println(date1);%></p>
                        <p >～</p>
                        <p id="record_data2"><%out.println(date2);%></p>
                    </div>
                    <div class="record_content_area">
                        <div class="record_content_area_1">
<%-- 紀錄 --%>            <!---->
                <form action="delete_record.jsp" onSubmit='return deleteFunction();'>
                    <table class='record_content' border="1">
<%
    int totoal_co2=0;
    int totoal_money=0;
    String olddate="";
    if(  date1.equals("") &&  date2.equals("")){
        sql= "SELECT * FROM `trade` WHERE `tAccount`=? order by `tDate`";
        ps= con.prepareStatement(sql);
        ps.setString(1, acc);
         rs = ps.executeQuery();
        if(rs.next()){
            olddate = rs.getString("tDate");
            out.println("<caption>"+rs.getString("tDate"));
            out.println("<button type='submit' class='change'>刪除</button></caption>");
            out.println("<tr><td><input type='checkbox' name='delete' value='"+rs.getInt("tID")+"'></td>");
            out.println("<td>"+rs.getString("tDetail")+"</td>");
            out.println("<td>"+rs.getString("tGoods")+"</td>");
            out.println("<td>"+rs.getString("tShop")+"</td>");
            out.println("<td>"+rs.getInt("tUnit")+"</td>");
            out.println("<td>金額："+rs.getInt("tMoney")+"元</td>");
            out.println("<td>碳足跡："+rs.getInt("tCO2")+"kg</td>");
            out.println("</tr>");
        }
        

        while(rs.next()){
            if(rs.getString("tDate").equals(olddate)){
                out.println("<tr><td><input type='checkbox' name='delete' value='"+rs.getInt("tID")+"'></td>");
                out.println("<td>"+rs.getString("tDetail")+"</td>");
                out.println("<td>"+rs.getString("tGoods")+"</td>");
                out.println("<td>"+rs.getString("tShop")+"</td>");
                out.println("<td>"+rs.getInt("tUnit")+"</td>");
                out.println("<td>金額："+rs.getInt("tMoney")+"元</td>");
                out.println("<td>碳足跡："+rs.getInt("tCO2")+"kg</td>");
                out.println("</tr>");
            }
            else{
                out.println("</table>");
                out.println("<table class='record_content' border='1'>");
                out.println("<caption>"+rs.getString("tDate")+"</caption>");
                out.println("<tr><td><input type='checkbox' name='delete' value='"+rs.getInt("tID")+"'></td>");
                out.println("<td>"+rs.getString("tDetail")+"</td>");
                out.println("<td>"+rs.getString("tGoods")+"</td>");
                out.println("<td>"+rs.getString("tShop")+"</td>");
                out.println("<td>"+rs.getInt("tUnit")+"</td>");
                out.println("<td>金額："+rs.getInt("tMoney")+"元</td>");
                out.println("<td>碳足跡："+rs.getInt("tCO2")+"kg</td>");
                out.println("</tr>");
                olddate = rs.getString("tDate");
            }

        }
        sql= "SELECT sum(`tMoney`) FROM `trade` WHERE (`tAccount`=?)";
        ps= con.prepareStatement(sql);
        ps.setString(1, acc);
        rs = ps.executeQuery();
        rs.next();
        totoal_money = rs.getInt(1);
        sql= "SELECT sum(`tCO2`) FROM `trade` WHERE (`tAccount`=?)";
        ps= con.prepareStatement(sql);
        ps.setString(1, acc);
        rs = ps.executeQuery();
        rs.next();
        totoal_co2 = rs.getInt(1);
    }
    else{ 
        sql= "SELECT * FROM `trade` WHERE `tAccount`=? AND (`tDate` BETWEEN '"+date1+"' AND '"+date2+"' )order by `tDate`";
        ps= con.prepareStatement(sql);
        ps.setString(1, acc);
        rs = ps.executeQuery();
        if(rs.next()){
            olddate = rs.getString("tDate");
            out.println("<caption>"+rs.getString("tDate"));
            out.println("<button class='change' onclick='deleteFunction()'>刪除</button></caption>");
            out.println("<tr><td><input type='checkbox' name='delete' value='"+rs.getInt("tID")+"'></td>");
            out.println("<td>"+rs.getString("tDetail")+"</td>");
            out.println("<td>"+rs.getString("tGoods")+"</td>");
            out.println("<td>"+rs.getString("tShop")+"</td>");
            out.println("<td>"+rs.getInt("tUnit")+"</td>");
            out.println("<td>金額："+rs.getInt("tMoney")+"元</td>");
            out.println("<td>碳足跡："+rs.getInt("tCO2")+"kg</td>");
            out.println("</tr>");
        }

        while(rs.next()){
            if(rs.getString("tDate").equals(olddate)){
                out.println("<tr><td><input type='checkbox' name='delete' value='"+rs.getInt("tID")+"'></td>");
                out.println("<td>"+rs.getString("tDetail")+"</td>");
                out.println("<td>"+rs.getString("tGoods")+"</td>");
                out.println("<td>"+rs.getString("tShop")+"</td>");
                out.println("<td>"+rs.getInt("tUnit")+"</td>");
                out.println("<td>金額："+rs.getInt("tMoney")+"元</td>");
                out.println("<td>碳足跡："+rs.getInt("tCO2")+"kg</td>");
                out.println("</tr>");
            }
            else{out.println("</table>");
                out.println("<table class='record_content' border='1'>");
                out.println("<caption>"+rs.getString("tDate")+"</caption>");
                out.println("<tr><td><input type='checkbox' name='delete' value='"+rs.getInt("tID")+"'></td>");
                out.println("<td>"+rs.getString("tDetail")+"</td>");
                out.println("<td>"+rs.getString("tGoods")+"</td>");
                out.println("<td>"+rs.getString("tShop")+"</td>");
                out.println("<td>"+rs.getInt("tUnit")+"</td>");
                out.println("<td>金額："+rs.getInt("tMoney")+"元</td>");
                out.println("<td>碳足跡："+rs.getInt("tCO2")+"kg</td>");
                out.println("</tr>");
                olddate = rs.getString("tDate");
            }

        }
                
                 
        sql= "SELECT sum(`tMoney`) FROM `trade` WHERE (`tAccount`=?)";
        ps= con.prepareStatement(sql);
        ps.setString(1, acc);
        rs = ps.executeQuery();
        rs.next();
        totoal_money = rs.getInt(1);
        sql= "SELECT sum(`tCO2`) FROM `trade` WHERE (`tAccount`=?)";
        ps= con.prepareStatement(sql);
        ps.setString(1, acc);
        rs = ps.executeQuery();
        rs.next();
        totoal_co2 = rs.getInt(1);

        

    }

    
        
%>       
            <script>
                        function deleteFunction()
                        {
                            y = confirm("請注意！每刪除一筆紀錄將扣除一點！")
                            if(y==true)
                                alert("已扣點 ( ´; ω ; )")
                        }
                    </script>
                    </table>
                </form>
                    
                    
                    </div>
                    </div>
                    </div>
                    <div id="record_sum" >
                        <table>
                            <tr>
                                <td>總計　</td>
                                <td>金額：　</td>
                                <td><%out.println(totoal_money);%></td>
                                <td>元　碳足跡：　</td>
                                <td id="record_sum_g"><%out.println(totoal_co2);%></td>
                                <td>　kg</td>
                            </tr>
                        </table>
                    </div>
                </section>
            </div>
        </aside>
    </main>
    <div id="to_top">
        <div id="top"></div>
        <a href="#">
            <img src="../asset/img/earth-day.png" alt="" id="top_btn">
        </a>
    </div>
<%
    }
%>
   
    <footer></footer>
    <iframe src="../page/nav.html" id="navBar" frameborder="0" scrolling="no"></iframe>
</body>
</html>
