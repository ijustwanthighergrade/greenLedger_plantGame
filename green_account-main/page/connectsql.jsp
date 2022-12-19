<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%
    Class.forName("com.mysql.jdbc.Driver");	  
    String url = "jdbc:mysql://localhost/?serverTimezone=UTC";
    Connection con = DriverManager.getConnection(url,"root","1234");
    String sql = "USE `green`";
    con.createStatement().execute(sql);
    
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>