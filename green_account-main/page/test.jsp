
<div class='signin' id='signin'><div class='signmid' ><form  action='login_mem.jsp' method='post'>
<div class='signcontent'><label name='lacc' for='account'>帳號：<br></label>
<input type='text' placeholder='你的帳號' ></div><div class='signcontent'><label for='account'>密碼：<br></label>
<input name='lpwd' type='password' placeholder='你的密碼' ></div><div class='signbtn'>
<input type='submit' value='登入' id='login'><input id='show' type='button' value='註冊'></div></form>
<dialog id='infoModal'><main><div class='big'><div class='mid'><div class='contain'><h2 class='h2card'>會員基本資料</h2>
<form action='reg_mem.jsp' method='post'><div class='info'><div class='data'><label for='account'>帳號：<br></label>
<input class='inputstyle' name='racc' type='text' placeholder='你的帳號'></div>
<div class='data'><label for='name'>密碼：<br></label><input name='rpwd' class='inputstyle' type='password' placeholder='你的密碼'></div>
<div class='data'><label for='name'>姓名：<br></label><input name='rname' class='inputstyle' type='text' placeholder='Your Name'>
</div><div class='data'><label for='name'>電子信箱：<br></label><input name='rmail' class='inputstyle' type='text' placeholder='Your E-mail'></div>
<div class='data'><label for='name'>生日：<br></label><input name='rbirth' class='inputstyle' type='date' ></div>
<div class='data'><label for='name'>性別：<br></label><input  type='radio' value='男' name='sexual' style='margin: 20px 20px 5px;'>男<br><input  type='radio' value='女' name='sexual' style='margin: 20px 20px'>女<br></div>
<div class='data'><label for='name'>通訊地址：<br></label><input name='radd' class='inputstyle' type='text' placeholder='你的住址'></div>
<div class='data'><label for='name'>聯絡電話：<br></label><input name='rphone' class='inputstyle' type='text' placeholder='你的電話'></div>
<div class='btndiv'><input type='submit' value='確認' class='btn' id='close'></div>
<div class='btndiv'><input type='reset' value='取消' class='btn' id='close_2'>
</div></div></form></div></div></div></main></dialog></div></div>