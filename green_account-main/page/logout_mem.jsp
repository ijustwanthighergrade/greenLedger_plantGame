<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 
<%
    session.removeAttribute("mem_account");
    response.sendRedirect("index.jsp");
%>
