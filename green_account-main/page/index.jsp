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
    <link rel="icon" href="asset/img/green-power.png" type="image/x-icon" />
    <title>存碳養綠</title>
    <style>

        @import url(asset/css/main.css);
        @import url(asset/css/index.css);
        @import url(asset/css/nav.css);
        @import url(../asset/css/animation.css);
    </style>
</head>
<body>
    <main>
        <aside id="main_title">
            <h1>理念</h1>
        </aside>

        <%
            if(session.getAttribute("mem_account")==null||session.getAttribute("mem_account").equals("")){
                out.println("<div class='signin' id='signin'><div class='signmid' ><div class='signcontent'><label for='account'>帳號：<br></label>");
                out.println("<input type='text' placeholder='你的帳號' ></div><div class='signcontent'><label for='account'>密碼：<br></label>");
                out.println("<input type='password' placeholder='你的密碼' ></div><div class='signbtn'>");
                out.println("<input type='submit' value='登入' id='login'><input id='show' type='button' value='註冊'>");
                out.println("</div><dialog id='infoModal'><main>");
                out.println("<div class='big'><div class='mid'><div class='contain'><h2 class='h2card'>會員基本資料</h2>");
                out.println("<div class='info'><div class='data'><label for='account'>帳號：<br></label>");
                out.println("<input class='inputstyle'type='text' placeholder='你的帳號'></div><div class='data'>");
                out.println("<label for='name'>密碼：<br></label><input class='inputstyle' type='password' placeholder='你的密碼'>");
                out.println("</div><div class='data'><label for='name'>姓名：<br></label>");
                out.println("<input class='inputstyle' type='text' placeholder='Your Name'></div><div class='data'>");
                out.println("<label for='name'>電子信箱：<br></label><input class='inputstyle' type='text' placeholder='Your E-mail'></div>");
                out.println("<div class='data'><label for='name'>生日：<br></label><input class='inputstyle' type='date' ></div>");
                out.println("<div class='data'><label for='name'>性別：<br></label>");
                out.println("<input  type='radio'  name='sexual' style='margin: 20px 20px 5px;'>男<br><input  type='radio'  name='sexual' style='margin: 20px 20px'>女<br>");
                out.println("</div><div class='data'><label for='name'>通訊地址：<br></label><input class='inputstyle' type='text' placeholder='你的住址'>");
                out.println("</div><div class='data'><label for='name'>聯絡電話：<br></label><input class='inputstyle' type='text' placeholder='你的電話'>");
                out.println("</div><div class='btndiv'><input type='submit' value='確認' class='btn' id='close'></div><div class='btndiv'>");
                out.println("<input type='reset' value='取消' class='btn' id='close_2'></div></div></div></div></div></main></dialog></div></div>");
            }
            else{
                out.println("<a href='logout_mem.jsp' class='manage'>登出</a>");
            }
        %>

        <div class="allhome">
            <div class="earth">
                <img src="asset/img/earth.png" >
            </div>
            <div class="idea">
                <div class="outer">
                    <div class="ideacontent">
                        <p>「存碳養綠」起源於一群大學生對於環境的重視，冀盼透過IT技術來替世界貢獻一份心意。雖然我們沒有龐大的資金、卓越的策劃，但憑藉一己之力，你我都能幫助世界向陽茁壯！</p>
                    </div>
                </div>
                <div class="outer">
                    <div class="ideacontent">
                        <p>存碳，使用綠色帳本紀錄日常生活碳排，揭開字裡行間的環境密碼，探尋更美好的生活模式。</p>
                    </div>
                </div>
                <div class="outer">
                    <div class="ideacontent">
                        <p>養綠，搭配獨家植物養成遊戲，讓我們攜手學習如何愛護地球，感受科技世界的生機盎然、川流不息。</p>
                    </div>
                </div>
                <div class="outer">
                    <div class="ideacontent">
                        <p>為了這世代的美好、下一代的未來，
                            邀請您一同與我們共襄盛舉，頌揚環境自然之美！</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer></footer>
    <iframe src="page/nav.html" id="navBar" frameborder="0" scrolling="no"></iframe>

    <script>
        //註冊介面
        let btn=document.querySelector("#show");
        let infoModal=document.querySelector("#infoModal");
        let close=document.querySelector("#close"); //註冊確認後關閉視窗
        let close_2=document.querySelector("#close_2"); //註冊取消關閉視窗
    
        btn.addEventListener("click", function(){
            infoModal.showModal();
        })
        close.addEventListener("click", function(){
            infoModal.close();
        })
        close_2.addEventListener("click", function(){
            infoModal.close();
        })

        //登入介面
        function login(){
            var div=document.getElementById("signin")
            if (div.style.display == "block") {
                div.style.display = "none";
            }
            else{
                div.style.display = "none";
            }
        }

    </script>
</body>
</html>
