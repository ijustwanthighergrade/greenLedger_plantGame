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
    <title>存炭養綠</title>
    <style>
        @import url(../asset/css/main.css);
        @import url(../asset/css/nav.css);
        @import url(../asset/css/user.css);
        @import url(../asset/css/animation.css);
    </style>
</head>
<body>
    <main>
        <aside id="main_title">
            <h1>會員中心</h1>
        </aside>
    <%
        if(session.getAttribute("mem_account") == null || session.getAttribute("mem_account").equals("")) {
           response.sendRedirect("index.jsp");
        }
        else{
            String acc = session.getAttribute("mem_account").toString();
            sql = "SELECT `vAccount` FROM `vip` WHERE `vAccount` ='" + acc + "'";
            //sql = "SELECT `mem_id`,`mem_password` FROM `login` WHERE `mem_account` ='adsasddsa@gmail.com'";
            ResultSet rs = con.createStatement().executeQuery(sql);
            rs.next();
            String id = rs.getString("vAccount");
            
            
            sql = "SELECT `vAccount`,`vName`,`vGender`,`vBirth`,`vMail`,`vPhone`,`vAddress`,`vPoint` FROM `vip` WHERE `vAccount` ='"+ id +"'";
            ResultSet rs1 = con.createStatement().executeQuery(sql);
            rs1.next();
    %>

        <div class="big">
            <div class="mid">
                <div class="contain">
                    <h2 class="h2card">會員基本資料</h2>
                    
                        <div class="info">
                            <div class="data">
                                <label for="account">帳號：<%out.println(rs1.getString("vAccount"));%><br></label>
                                
                            </div>
                            
                            <div class="data">
                                <label for="name">姓名：<%out.println(rs1.getString("vName"));%><br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">電子信箱：<%out.println(rs1.getString("vMail"));%><br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">生日：<%out.println(rs1.getString("vBirth"));%><br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">性別：<%out.println(rs1.getString("vGender"));%><br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">通訊地址：<%out.println(rs1.getString("vAddress"));%><br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">聯絡電話：<%out.println(rs1.getString("vPhone"));%><br></label>
                               
                            </div>

                            <div class="btndiv1">
                                <button id="update" > 修改</button>
                                <input type="button" id="update" onclick="location.href='logout_mem.jsp';" value="登出" />
                                
                            </div>

                            <dialog id="userupdate" style="background-color: rgb(12, 80, 36); width: 80%; border-radius: 10px;" >
                                <form action="changeinfo.jsp" method="post">
                                    <div class="contain">
                                        <h2 class="h2card">會員基本資料</h2>
                                            <div class="info">
                                                <div class="data">
                                                    <label for="name">密碼：<br></label>
                                                    <input name="pwd" class="inputstyle" type="password" placeholder="你的密碼">
                                                </div>
                                                <div class="data">
                                                    <label for="name">姓名：<br></label>
                                                    <input name="mname" class="inputstyle" type="text" placeholder="Your Name">
                                                </div>
                                                <div class="data">
                                                    <label for="name">電子信箱：<br></label>
                                                    <input name="memail" class="inputstyle" type="email" placeholder="Your E-mail">
                                                </div>
                                                <div class="data">
                                                    <label for="name">性別：<br></label>
                                                    <input  type="radio" value='男' name="sexual" style="margin: 20px 20px 5px;">男<br>
                                                    <input  type="radio" value='女' name="sexual" style="margin: 20px 20px">女<br>                                                    
                                                </div>
                                                <div class="data">
                                                    <label for="name">通訊地址：<br></label>
                                                    <input name="addr" class="inputstyle" type="text" placeholder="你的住址">
                                                </div>
                                                <div class="data">
                                                    <label for="name">聯絡電話：<br></label>
                                                    <input name="mphone" class="inputstyle" type="tel" placeholder="你的電話">
                                                </div>

                                                <div class="btndiv">
                                                    <input type="submit" value="確認" class="btn_update">
                                                    <input type="reset" value="取消" class="btn_update">
                                                </div>
                                            </div>
                                    </div>
                                </form>
                            </dialog>
             
                            <div class="userbottom">
                                <div class="pointdiv">
                                    <div class="pointmid">
                                        <p>持有點數：<%out.println(rs1.getInt("vPoint"));%></p>
                                        <button id="poitnbtn">兌換紀錄</button>
                                    </div>
                                </div>
                                <dialog id="pointhistory">
                                    <div class="bigpoint">
                                        <div class="midpoint">
                                            <h2 style="text-align: center; margin-bottom: 0px;">兌換紀錄</h2>
                                            <button id="close" >X</button>
                                            <%
                                                sql = "SELECT * FROM `tgoods`";
                                                rs = con.createStatement().executeQuery(sql);
                                                while(rs.next()){
                                                    String sqlg = "SELECT `gName`,`gPoint` FROM `goods` WHERE `gID`="+rs.getInt("tgID");
                                                    ResultSet rsg = con.createStatement().executeQuery(sqlg);
                                                    rsg.next();


                                                    out.println("<div class='pointcontent'>");
                                                    out.println("<p> 兌換時間："+rs.getString("tgDate")+"<br>");
                                                    out.println("商品 :"+rsg.getString("gName")+"  <br>");
                                                    out.println("點數 : " + rsg.getString("gPoint"));
                                                    out.println("</p>");
                                                    out.println("</div>");
                                                }
                                            %>
                                            
                                                
                                                    
                                                    
                                                
                                            

                                            
                                        </div>
                                    </div>
                                    
                                </dialog>
                            
                                
                            </div>

                                
                            
                        </div>
                    
                </div>
            </div>
        </div>
    </main>
    <iframe src="nav.html" id="navBar" frameborder="0" scrolling="no"></iframe>

                       <% }
                        %>  
    <script>
        let btn = document.querySelector("#poitnbtn")
        let btn2 = document.querySelector("#update")

        let pointhistory = document.querySelector("#pointhistory")
        let userupdate = document.querySelector("#userupdate")

        btn.addEventListener("click",function(){
            pointhistory.showModal();
        })
        btn2.addEventListener("click",function(){
            userupdate.showModal();
        })

        let close = document.querySelector("#close")
       
        close.addEventListener("click",function(){
            pointhistory.close();
        })

    </script>
</body>
</html>
