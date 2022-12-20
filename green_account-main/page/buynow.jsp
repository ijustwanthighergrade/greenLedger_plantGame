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
                    Integer id = Integer.parseInt(request.getParameter("id"));
                
                try{    
                    
                    
                    //減少商品庫存&取出點數 更新使用者點數
                    sql= "SELECT `gPoint`,`gStock` FROM `goods` WHERE (`gID`=?)";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1,id);
                    ResultSet rs = ps.executeQuery();
                    rs.next();
                    
                    
                    int gstock = rs.getInt("gStock"); //商品庫存
                    int gpoint = rs.getInt("gPoint"); //商品點數

                    if(gstock>0){
                        gstock--;

                        sql= "SELECT `vPoint` FROM `vip` WHERE (`vAccount`=?)";
                        ps = con.prepareStatement(sql);
                        ps.setString(1,acc);
                        rs = ps.executeQuery();
                        rs.next();
                        int vpoint = rs.getInt("vPoint"); //使用者點數
                        vpoint-=gpoint;                   //使用者點數 - 兌換之商品點數 => 更新使用者點數


                        String sql1 = "UPDATE `vip` SET `vPoint`=? WHERE `vAccount`=?";
                        ps = con.prepareStatement(sql1);
                        ps.setInt(1,vpoint);  
                        ps.setString(2,acc);  
                        int c_vip = ps.executeUpdate();

                        sql1 = "UPDATE `goods` SET `gStock`=? WHERE `gID`=?";
                        ps = con.prepareStatement(sql1);
                        ps.setInt(1,gstock);  
                        ps.setInt(2,id);  
                        int c_goods = ps.executeUpdate();



                        sql= "SELECT * FROM `tgoods` WHERE (`tgAccount`=?) AND (`tgDate`=?)";
                        ps = con.prepareStatement(sql);
                        ps.setString(1,acc);
                        ps.setString(2,credate);
                        rs = ps.executeQuery();
                                            
                        int c=0;
                        //插入點數交易明細
                        if( !rs.next() ){
                            String sqln = "INSERT INTO `tgoods` VALUES ( ? , ? , '"+ credate +"')";
                            PreparedStatement psincart = con.prepareStatement(sqln);
                            psincart.setString(1,acc);
                            psincart.setInt(2,id);
                            c = psincart.executeUpdate();
                        }
                        else{
                            ctime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
                            credate = ctime.format(new java.util.Date()); 
                            String sqln = "INSERT INTO `tgoods` VALUES ( ? , ? , '"+ credate +"')";
                            PreparedStatement psincart = con.prepareStatement(sqln);
                            psincart.setString(1,acc);
                            psincart.setInt(2,id);
                            c = psincart.executeUpdate();
                        }

                        out.println(c +"<br>"+ c_vip+"<br>" +c_goods);
                        if ( c > 0 && c_vip > 0 && c_goods > 0){
                            con.close();%>
                                <script type="text/javascript">
                                    alert("兌換成功");
                                    
                                </script>

                    <%response.sendRedirect("shop.jsp");
                        }
                    }
                    else{%>
                        <script type="text/javascript">
                            alert("庫存不足，已無法兌換");
                            history.back()
                        </script>

                    <%

                    }


                        

                    }catch(NumberFormatException ex){ 
%>
                        <script type="text/javascript">
                            alert("操作錯誤，系統將返回產品頁");
                            window.history.go(-2);
                        </script>

                    <% } 
                    }catch (SQLException sExec){ 
                    
                    %>

                        <script type="text/javascript">
                            alert("操作錯誤，系統將返回產品頁");
                            window.history.go(-2);
                        </script>

                <% 
                }    
                }
                %>                      