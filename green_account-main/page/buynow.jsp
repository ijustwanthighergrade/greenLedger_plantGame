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
                    
                    sql= "SELECT * FROM `tgoods` WHERE (`tgAccount`=?) AND (`tgID`=?)";
                    PreparedStatement ps = con.prepareStatement(sqlc);
                    ps.setString(1,acc);
                    ps.setString(2,id);
                    ResultSet rscart = pscart.executeQuery();
                    
                                        
                    int c=0;
                    if( !rscart.next() ){
                        String sqln = "INSERT INTO `tgoods` VALUES ( ? , ? , ?, '"+ credate +"')";
                        PreparedStatement psincart = con.prepareStatement(sqln);
                        psincart.setString(1,id);
                        psincart.setString(2,productid);
                        psincart.setInt(3,quantity);
                        c = psincart.executeUpdate();
                    }
                    else{
                        String sqlu = "UPDATE `cart` SET `order_amount`= `order_amount`+?, `add_Date`='"+ credate +"' WHERE (`mem_id`=?) AND (`product_id`=?)";
                       
                        PreparedStatement pstocart = con.prepareStatement(sqlu);
                        pstocart.setInt(1,quantity);
                        pstocart.setString(2,id);
                        pstocart.setString(3,productid);
                        c = pstocart.executeUpdate();
                    }
                    
                    if ( c > 0 )
                        response.sendRedirect("car.jsp"); 
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