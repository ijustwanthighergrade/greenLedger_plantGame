<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <style media="screen" type="text/css">
        @import url(../asset/css/metaforms.css);
    </style>
    <title>Login</title>
  </head>
  
  <body>  
      <form action="login_man.jsp" id="login_form">
        <div class="login">
            <div >
                <div>
                    <div>
                        <span>帳號：</span>
                        <input type="text" placeholder="account" name="acc">
                    </div>
                    
                    <div>
                        <span>密碼：</span>
                        <input type="text" placeholder="passcode" name="pwd">
                    </div>
                    <br>
    
                    <button onclick="">登入</button>
                </div>
            </div>
        </div>
      </form>
  </body>
</html>
