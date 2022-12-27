<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*, java.util.*"%>
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
        @import url(../asset/css/game.css);
        @import url(../asset/css/animation.css);
    </style>
    <link rel="stylesheet" href="../asset/css/picturesbook.css">
    <link rel="stylesheet" href="../asset/css/question.css">
</head>
<body>
    <main>
        <aside id="main_title">
            <h1>植物養成手冊</h1>
        </aside>
        <%
            if(session.getAttribute("mem_account") == null || session.getAttribute("mem_account").equals("")) {
                response.sendRedirect("index.jsp");
            }
            else{
                String acc = session.getAttribute("mem_account").toString();
                /* Select `搜索欄位` From `指定表格` Where `指定欄位`==`指定條件` */
                sql = "SELECT `vAccount` FROM `vip` WHERE `vAccount` ='" + acc + "'";
                ResultSet rs = con.createStatement().executeQuery(sql);
                rs.next();
                String id = rs.getString("vAccount");
                sql = "SELECT * FROM `vflower` WHERE `vfAccount` ='"+ id +"'";
                ResultSet rs_vf = con.createStatement().executeQuery(sql);
                rs_vf.next();
        %>       
        <div class="bighand">
            <div class="handbook">
                <div class="bar">
                    <div class="point">
                        <div class="barpoint">
                            <p>目前點數：100</p>
                        </div>
                    </div>
                    <div class="up">
                        <div class="bar1">
                            <p>成長值：<%out.println(rs_vf.getInt("vfGrow"));%>/100</p>
                        </div>
                    </div>
                    <div class="die">
                        <div class="bar2">
                            <p>枯萎值：<%out.println(rs_vf.getInt("vfDead"));%>/100</p>
                        </div>
                    </div>
                </div>
                <div class="watercan">
                    <img src="../asset/img/watercan.png">
                </div>
                <div class="grass">
                    <div class="seed">
                    <%
                        PreparedStatement stmt;
                        String vf_type = rs_vf.getString("vfType");
                        if( vf_type=="開花" ){
                            int vfID = rs_vf.getInt("vfID");
                            sql = "SELECT * FROM `photo` WHERE `pID`='"+ vfID +"'";
                            ResultSet rs_f = con.createStatement().executeQuery(sql);
                            rs_f.next();
                            out.println("<img src='../asset/img/"+ rs_f.getString("pImg") +"' alt='"+ vf_type +"'></a>");
                            sql = "SELECT * FROM `vphoto` WHERE `vpAccount`='"+ id +"' and `vpID`='"+ vfID +"'";
                            rs_f = con.createStatement().executeQuery(sql);
                            if( !(rs_f.next()) ){
                                sql = "INSERT INTO `vphoto` VALUE('"+ id +"','"+ vfID +"')";
                                stmt = con.prepareStatement(sql);
                                stmt.executeUpdate();
                            }
                            Random ran = new Random();
                            int random = ran.nextInt(3)+1;
                            sql = "UPDATE `vflower` SET `vfID`=?,`vfType`=?,`vfGrow`=?,`vfDead`=? WHERE `vfAccount`='"+ id +"'";
                            stmt = con.prepareStatement(sql);
                            stmt.setInt(1, random);
                            stmt.setString(2, "種子");
                            stmt.setInt(3, 0);
                            stmt.setInt(4, 0);
                            stmt.executeUpdate();
                        }else{
                            sql = "SELECT * FROM `flower` WHERE `fType` = '"+ vf_type +"'";
                            ResultSet rs_f = con.createStatement().executeQuery(sql);
                            rs_f.next();
                            out.println("<img src='../asset/img/"+ rs_f.getString("fImg") +"' alt='"+ vf_type +"'></a>");
                        }
                    %>
                    </div>
                    <div class="green">
                        <p style="padding: 10px;margin-left: 15px;">
                            <%
                                out.println("可澆水次數 : ");
                                sql = "SELECT * FROM `back` WHERE `bAccount` ='"+ id +"'";
                                ResultSet rs_vbage = con.createStatement().executeQuery(sql);
                                int water_time = -99;
                                while(rs_vbage.next()){
                                    if(rs_vbage.getInt("bID")==2){ //bID=2 : "澆水"
                                        water_time = rs_vbage.getInt("bAmount");
                                        break;
                                    }
                                }
                                if(water_time==-99){
                                    out.println("NULL");
                                }else{
                                    out.println(water_time);
                                }
                            %>
                        </p>
                    </div>
                </div>
                <div class="press">
                    <div id="pcturebook">
                        <input type="button" class="btn1" value="圖鑑">
                    </div>
                    <dialog id="infoModal">
                        <div class="bigpic">
                            <div class="picbody1">
                                <div class="sub">
                                    <img src="../asset/img/leaf.png" >
                                    <div class="subtitle">
                                        <p>圖鑑</p>
                                    </div>
                                </div>
                                <%
                                    /* 花卉圖鑑 */
                                    sql = "SELECT * FROM `photo`";
                                    ResultSet rs_fDict = con.createStatement().executeQuery(sql);
                                    sql = "SELECT * FROM `vphoto` WHERE `vpAccount` = '"+ id +"'";
                                    ResultSet rs_vfDict = con.createStatement().executeQuery(sql);
                                    out.println("<div class='all1'>");
                                    int i=1;
                                    int haveID = 0;
                                    while(rs_vfDict.next()){
                                        haveID = rs_vfDict.getInt("vpID");
                                        while(rs_fDict.next()){
                                            if( haveID == i ){
                                                out.println("<div class='no1'>");
                                                out.println("<div class='pic1'>");
                                                out.println("<img src='../asset/img/"+rs_fDict.getString("pImg")+"' >");
                                                out.println("</div>");
                                                out.println("<p>"+rs_fDict.getString("pName")+"</p>");
                                                out.println("</div>");
                                            }else{
                                                out.println("<div class='no1'>");
                                                out.println("<div class='pic1'>");
                                                out.println("<img src='../asset/img/lock.png' >");
                                                out.println("</div>");
                                                out.println("<p>未解鎖</p>");
                                                out.println("</div>");
                                            }
                                            i++;
                                        }
                                    }
                                    while(rs_fDict.next()){                    
                                        out.println("<div class='no1'>");
                                        out.println("<div class='pic1'>");
                                        out.println("<img src='../asset/img/lock.png' >");
                                        out.println("</div>");
                                        out.println("<p>未解鎖</p>");
                                        out.println("</div>");
                                    }
                                    out.println("</div>");
                                %>
                            </div>
                        </div>
                        <button id="close">X</button>
                    </dialog>
                    <div id="question">
                        <input type="button" class="btn1" value="環保&#010;小問題"  >
                    </div>
                    <dialog id="questionModal">
                        <div class="bigpic">
                            <div class="picbody" style="width: 450px;">
                                <div class="sub">
                                    <img src="../asset/img/leaf.png" >
                                    <div class="subtitle2">
                                        <p style="font-size: 30px;">環保<br>小問題</p>
                                    </div>
                                </div>
                                <div class="all2">
                                    <div class="no1">
                                    <% 
                                        /* 題目 */
                                        Random ran = new Random();
                                        int random = ran.nextInt(50)+1;
                                        sql = "SELECT * FROM `exam` WHERE `eID` ='"+ random +"'";
                                        ResultSet rs_exam = con.createStatement().executeQuery(sql);
                                        rs_exam.next();
                                        out.println("<p>"+ rs_exam.getString("eTopic") +"</p>");
                                        out.println("<div class='questiondiv'>");
                                        out.println("<div class='question'>");
                                        out.println("<form action=''>");
                                        out.println("<input type='radio' name='question' class='bnt_question'  checked><label >(1) "+ rs_exam.getString("eYes") +"</label> <br>");
                                        out.println("<input type='radio' name='question' class='bnt_question'  ><label >(2) "+ rs_exam.getString("eWrongA") +"</label> <br>");
                                        out.println("<input type='radio' name='question' class='bnt_question'  ><label >(3) "+ rs_exam.getString("eWrongB") +"</label> <br>");
                                        out.println("<input type='radio' name='question' class='bnt_question'  ><label >(4) "+ rs_exam.getString("eWrongC") +"</label> ");
                                        out.println("</form>");
                                        out.println("</div>");
                                        out.println("</div>");
                                    %>
                                        <div class="confirmdiv">
                                            <input type="submit"  class="confirm" value="確定選擇" style="cursor: pointer;" onclick="confrimalert()">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button class="cls" onclick="questionModal.close()">X</button>
                    </dialog>
                    <div id="check">
                        <input type="button" class="btn1" value="簽到">
                    </div>
                    <dialog id="checkModal">
                        <div class="bigpic">
                            <div class="picbody" style="width: 450px;">
                                <div class="sub">
                                    <img src="../asset/img/leaf.png" >
                                    <div class="subtitle">
                                        <p>簽到</p>
                                    </div>
                                </div>
                                <div class="all">
                                    <div class="no1">
                                        <p>這週簽到表</p>
                                        <div class="allcheck">
                                        <%
                                            /* 每日打卡 */
                                            Calendar calendar = Calendar.getInstance();
                                            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
                                            String[] week = {"sMon","sTue","sWed","sThu","sFri","sSat","sSun"};
                                            dayOfWeek = (dayOfWeek+5)%7;
                                            sql = "UPDATE `sign` SET `"+ week[dayOfWeek] +"`=? WHERE `sAccount`=?";
                                            
                                            stmt = con.prepareStatement(sql);
                                            stmt.setInt(1,1);
                                            stmt.setString(2,id);
                                            stmt.executeUpdate();
                                            /* 輸出一周登入狀況 */
                                            sql = "SELECT * FROM `sign` WHERE `sAccount` = '"+ id +"'";
                                            ResultSet rs_week = con.createStatement().executeQuery(sql);
                                            rs_week.next();
                                            String today = "";
                                            int flag=-1;
                                            for(int day=0;day<7;day++){
                                                today = week[day];
                                                flag = rs_week.getInt(today);
                                                out.println("<div class='checkdiv'>");
                                                out.println("<div class='check1'>");
                                                if( flag==1 )
                                                    out.println("<img src='../asset/img/check-mark.png' >");
                                                else
                                                    out.println("<img src='../asset/img/no.png' >");
                                                out.println("</div>");
                                                out.println("</div>");
                                            }
                                        %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <button class="cls" onclick="checkModal.close()">X</button>
                     </dialog>
                    <div id="item">
                        <input type="button" class="btn1" value="道具" >
                    </div>
                    <dialog id="itemModal">
                        <div class="bigpic" >
                            <div class="picbody" style="width: 900px;">
                                <div class="sub">
                                    <img src="../asset/img/leaf.png" >
                                    <div class="subtitle">
                                        <p>道具</p>
                                    </div>
                                </div>
                                <div class="all" >
                                    <div class="no1" >
                                        <div class="alltoy" >
                                        <%
                                            /* 道具背包 */
                                            sql = "SELECT * FROM `back` WHERE `bAccount` ='"+ id +"'";
                                            rs_vbage = con.createStatement().executeQuery(sql);
                                            sql = "SELECT * FROM `item` ";
                                            ResultSet rs_item = con.createStatement().executeQuery(sql);
                                            String iName = "";
                                            String iImg = "";
                                            while( rs_item.next() && rs_vbage.next() ){
                                                iName = rs_item.getString("iName");
                                                iImg = rs_vbage.getString("bImg");
                                                out.println("<div class='toydiv'>");
                                                out.println("<div class='toy1'>");
                                                out.println("<span data-texto='"+ iName +"'><img src='../asset/img/"+ iImg +".png' ></span>");
                                                out.println("</div>");
                                                out.println("</div>");
                                            }
                                        %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <button class="cls" onclick="itemModal.close()" >X</button>
                     </dialog>
                </div>
    
            </div>
        </div>
        
    </main>
    <script>
        //遊戲主畫面之按鍵設定
        let btn=document.querySelector("#pcturebook");
        let btn2=document.querySelector("#question");
        let btn3=document.querySelector("#check");
        let btn4=document.querySelector("#item");

        let infoModal=document.querySelector("#infoModal");
        let questionModal=document.querySelector("#questionModal");
        let checkModal=document.querySelector("#checkModal");
        let itemModal=document.querySelector("#itemModal");
       
        let close=document.querySelector("#close");
        
        btn.addEventListener("click", function(){
        infoModal.showModal();
        })
        btn2.addEventListener("click", function(){
        questionModal.showModal();
        })
        btn3.addEventListener("click", function(){
        checkModal.showModal();
        })
        btn4.addEventListener("click", function(){
        itemModal.showModal();
        })

        close.addEventListener("click", function(){
        infoModal.close();  
        })

        //環保小問題之按鍵設定
        function confrimalert(){
            var yes = confirm('確定送出答案嗎？');
            if (yes) {
                <%
                    sql = "UPDATE `back` SET `bAmount`=? WHERE `bAccount`='"+ id +"' and `bID`=2";
                    stmt = con.prepareStatement(sql);
                    stmt.setInt(1,water_time+2);
                    stmt.executeUpdate();
                %>
                alert('答對了！可再澆兩次水！');
            } else {
                <%
                    sql = "UPDATE `back` SET `bAmount`=? WHERE `bAccount`='"+ id +"' and `bID`=2";
                    stmt = con.prepareStatement(sql);
                    stmt.setInt(1,water_time+1);
                    stmt.executeUpdate();
                %>
                alert('答錯了！只能加一次QQ！');
            }
        }
    </script>
    <iframe src="../page/nav.html" id="navBar" frameborder="0" scrolling="no"></iframe>
    <% }%>
</body>
</html>
