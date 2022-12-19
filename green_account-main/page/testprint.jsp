<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "connectsql.jsp" %> 

<%
    String racc = request.getParameter("racc"); 
    String rpwd = request.getParameter("rpwd");
    String rname = request.getParameter("rname");
    String rmail = request.getParameter("rmail");
    String rbirth = request.getParameter("rbirth");
    String sexual = request.getParameter("sexual");
    String radd = request.getParameter("radd");
    String rphone = request.getParameter("rphone");
    int i = 0;
    out.println(racc+"<br>" +rpwd+"<br>"+rname+"<br>"+rmail+"<br>"+rbirth+"<br>"+sexual+"<br>"+radd+"<br>"+rphone+i);
%>