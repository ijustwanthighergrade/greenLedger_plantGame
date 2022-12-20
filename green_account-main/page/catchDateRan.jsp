<%@ page language="java"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import="java.sql.*"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8"); 
    SimpleDateFormat time = new SimpleDateFormat("yyyyMMddhhmmss");  
    String CDate = time.format(new java.util.Date()); 
    
    SimpleDateFormat ctime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
    String credate = ctime.format(new java.util.Date()); 
    
    //out.println(CDate);
    int num = Math.round( (float)Math.random()*1000);
    while ( num < 100){
        num = Math.round( (float)Math.random()*1000);
    }
    String RanNum = "" + num;
    CDate += RanNum;
    //out.println(CDate);
%>
