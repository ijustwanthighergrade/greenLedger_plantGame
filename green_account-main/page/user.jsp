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

        <div class="big">
            <div class="mid">
                <div class="contain">
                    <h2 class="h2card">會員基本資料</h2>
                    
                        <div class="info">
                            <div class="data">
                                <label for="account">帳號：<br></label>
                                
                            </div>
                            
                            <div class="data">
                                <label for="name">姓名：<br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">電子信箱：<br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">生日：<br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">性別：<br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">通訊地址：<br></label>
                                
                            </div>
                            <div class="data">
                                <label for="name">聯絡電話：<br></label>
                               
                            </div>

                            <div class="btndiv1">
                                <button id="update" > 修改</button>
                                <input type="button" id="update" onclick="location.href='logout_mem.jsp';" value="登出" />
                                <%-- <a href='logout_mem.jsp' >登出</a> --%>
                            </div>

                            <dialog id="userupdate" style="background-color: rgb(12, 80, 36); width: 80%; border-radius: 10px;" >
                                <form>
                                    <div class="contain">
                                        <h2 class="h2card">會員基本資料</h2>
                                        
                                            <div class="info">
                                                <div class="data">
                                                    <label for="account">帳號：<br></label>
                                                    <input class="inputstyle"type="text" placeholder="你的帳號">
                                                </div>
                                                <div class="data">
                                                    <label for="name">密碼：<br></label>
                                                    <input class="inputstyle" type="password" placeholder="你的密碼">
                                                </div>
                                                <div class="data">
                                                    <label for="name">姓名：<br></label>
                                                    <input class="inputstyle" type="text" placeholder="Your Name">
                                                </div>
                                                <div class="data">
                                                    <label for="name">電子信箱：<br></label>
                                                    <input class="inputstyle" type="email" placeholder="Your E-mail">
                                                </div>
                                                <div class="data">
                                                    <label for="name">生日：<br></label>
                                                    
                                                </div>
                                                <div class="data">
                                                    <label for="name">性別： 女<br></label>
                                                    
                                                </div>
                                                <div class="data">
                                                    <label for="name">通訊地址：<br></label>
                                                    <input class="inputstyle" type="text" placeholder="你的住址">
                                                </div>
                                                <div class="data">
                                                    <label for="name">聯絡電話：<br></label>
                                                    <input class="inputstyle" type="tel" placeholder="你的電話">
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
                                        <p>持有點數：</p>
                                        <button id="poitnbtn">兌換紀錄</button>
                                    </div>
                                </div>
                                <dialog id="pointhistory">
                                    <div class="bigpoint">
                                        <div class="midpoint">
                                            <h2 style="text-align: center; margin-bottom: 0px;">兌換紀錄</h2>
                                            <button id="close" >X</button>
                                            <div class="pointcontent">
                                                <p>2022 / 12 / 18<br>
                                                    16 : 41 <br>
                                                    商品 :  <br>
                                                    點數 : 
                            
                                                </p>
                                                
                                            </div>
                                            <div class="pointcontent">
                                                <p>2022 / 12 / 18<br>
                                                    16 : 41 <br>
                                                    商品 :  <br>
                                                    點數 : 
                            
                                                </p>
                                                
                                            </div>
                                            <div class="pointcontent">
                                                <p>2022 / 12 / 18<br>
                                                    16 : 41 <br>
                                                    商品 :  <br>
                                                    點數 : 
                            
                                                </p>
                                                
                                            </div>
                                            <div class="pointcontent">
                                                <p>2022 / 12 / 18<br>
                                                    16 : 41 <br>
                                                    商品 :  <br>
                                                    點數 : 
                            
                                                </p>
                                                
                                            </div>
                                            
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
