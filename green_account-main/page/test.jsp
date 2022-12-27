<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 
<%

        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
        java.util.Date date = new java.util.Date();
        java.sql.Date now1 = new java.sql.Date(date.getTime()); 
        String a = sdf.format(now1);
        out.println(a);
%>
