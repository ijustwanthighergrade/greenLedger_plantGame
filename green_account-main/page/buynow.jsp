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
       
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");  
            String acc = session.getAttribute("mem_account").toString();   
            Integer id = Integer.parseInt(request.getParameter("id"));
            
             
                
                
                //減少商品庫存&取出點數 更新使用者點數
                sql= "SELECT `gPoint`,`gStock` FROM `goods` WHERE (`gID`=?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1,id);
                ResultSet rs = ps.executeQuery();
                rs.next();
                int gstock = rs.getInt("gStock"); //商品庫存
                int gpoint = rs.getInt("gPoint"); //商品點數
                sql= "SELECT `vPoint` FROM `vip` WHERE (`vAccount`=?)";
                ps = con.prepareStatement(sql);
                ps.setString(1,acc);
                rs = ps.executeQuery();
                rs.next();
                int vpoint = rs.getInt("vPoint"); //使用者點數

                if(vpoint>0 && gpoint<=vpoint ){
                    if(gstock>0){
                        gstock--;
                        
                        vpoint-=gpoint; //使用者點數 - 兌換之商品點數 => 更新使用者點數


                        //更新使用者點數
                        String sql1 = "UPDATE `vip` SET `vPoint`=? WHERE `vAccount`=?";
                        ps = con.prepareStatement(sql1);
                        ps.setInt(1,vpoint);  
                        ps.setString(2,acc);  
                        int c_vip = ps.executeUpdate();
                        //更新商品庫存
                        sql1 = "UPDATE `goods` SET `gStock`=? WHERE `gID`=?";
                        ps = con.prepareStatement(sql1);
                        ps.setInt(1,gstock);  
                        ps.setInt(2,id);  
                        int c_goods = ps.executeUpdate();



                        sql= "SELECT COUNT(*) FROM `tgoods` WHERE (`tgAccount`=?)";
                        ps= con.prepareStatement(sql);
                        ps.setString(1, acc);
                        int count_id =0;
                        rs = ps.executeQuery();
                        rs.next();

                        if(rs.getInt(1)>0){
                            sql= "SELECT `tgoodsid` FROM `tgoods` order by `tgoodsid` desc";
                            ps= con.prepareStatement(sql);
                            rs = ps.executeQuery();
                            rs.next();
                            count_id=rs.getInt(1);
                        }
                        else{
                            count_id=rs.getInt(1);
                        }
                            count_id++;
                                            
                        int c=0;
                        //插入點數交易明細

                        String sqln = "INSERT INTO `tgoods` VALUES (?, ? , ? , '"+credate+"')";
                        PreparedStatement psincart = con.prepareStatement(sqln);
                        psincart.setInt(1,count_id);
                        psincart.setString(2,acc);
                        psincart.setInt(3,id);
                        c = psincart.executeUpdate();

                        out.println(c +"<br>"+ c_vip+"<br>" +c_goods);
                        if ( c > 0 && c_vip > 0 && c_goods > 0){
                            con.close(); %>

                            <script type="text/javascript">
                                alert("兌換成功");
                            </script>

                        <% 
                        response.sendRedirect("shop.jsp");
                            }
                        }
                        else{
                        %>
                            <script type="text/javascript">
                                alert("庫存不足，已無法兌換");
                                history.back()
                            </script>

                        <%

                    }

                }
                else{
                    %>
                        <script type="text/javascript">
                            alert("點數不足無法兌換");
                            history.back()
                        </script>

                    <%
                }

                    

            
                

            
              
    }
            %>                      