<%@ page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import ="java.sql.*"%>
<%@include file = "catchDateRan.jsp" %> 

    <%
    if(session.getAttribute("mem_account")==null||session.getAttribute("mem_account").equals("")){
                response.sendRedirect("index.jsp");
    }
    else{    
        try{
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");              

                    String acc = session.getAttribute("mem_account").toString();   
                    String id = request.getParameter("id");
                
                try{    
                    
                    sql= "SELECT * FROM `tgoods` WHERE (`tgAccount`=?) AND (`tgDate`=?)";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1,acc);
                    ps.setString(2,credate);
                    ResultSet rs = ps.executeQuery();
                                        
                    int c=0;
                    //插入點數交易明細
                    if( !rscart.next() ){
                        String sqln = "INSERT INTO `tgoods` VALUES ( ? , ? , '"+ credate +"')";
                        PreparedStatement psincart = con.prepareStatement(sqln);
                        psincart.setString(1,acc);
                        psincart.setString(2,id);
                        c = psincart.executeUpdate();
                    }
                    else{
                        ctime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
                        credate = ctime.format(new java.util.Date()); 
                        String sqln = "INSERT INTO `tgoods` VALUES ( ? , ? , '"+ credate +"')";
                        PreparedStatement psincart = con.prepareStatement(sqln);
                        psincart.setString(1,acc);
                        psincart.setString(2,id);
                        c = psincart.executeUpdate();
                    }
                    //減少商品庫存&取出點數
                    sql= "SELECT `gPoint`,`gStock` FROM `goods` WHERE (`gID`=?)";
                    ps = con.prepareStatement(sql);
                    ps.setString(1,id);
                    rs = ps.executeQuery();
                    
                    int gstock = rs.getInt("gStock");
                    int gpoint = rs.getInt("gPoint");
                    gstock--;

                    sql= "SELECT `gPoint`,`gStock` FROM `goods` WHERE (`gID`=?)";
                    ps.setString(1,acc);
                    rs = ps.executeQuery();



                    String sql1 = "UPDATE `vip` SET `vPoint`=? WHERE `vAccount`=?";
                    ps.setString(1,acc);  
                    int change = ps.executeUpdate();







                    if ( c > 0 )
                        response.sendRedirect("shop.jsp"); 
                    }catch(NumberFormatException ex){%>

                        <script type="text/javascript">
                            alert("操作錯誤，系統將返回產品頁");
                            window.history.go(-2);
                        </script>

                    <%} 
                    }catch (SQLException sExec){ %>

                        <script type="text/javascript">
                            alert("操作錯誤，系統將返回產品頁");
                            window.history.go(-2);
                        </script>

                <% }    
                }
                %>                      